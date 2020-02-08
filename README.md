# vim-uniquetag
Vim 用のユニークなタグ文字列生成プラグイン

文章の特定位置を指し示すためのユニークなタグを生成します。

*    挿入されるタグの例

     ```
     [ID:4C42]
     ```

## 使い方

*    挿入モードで使用する場合

     ```
     " <ESC>t でタグを挿入する場合
     imap <ESC>t <Plug>(uniquetag-insert-tag)
     ```

*   ノーマルモードで使用する場合

    ```
    :UniqueTag
    ```

## カスタマイズ

通常は、タグを `[ID:` と `]` で囲むみ、
ファイルタイプ vim はタグを `"ref:` を先頭につける

```
  " *: [ID:67AE]
  " vim: "ref:5CE0
  let g:uniquetag_config = #{
    '*': #{
      prefix: '[ID:',
      length: 4,
      suffix: ']',
    },
    'vim': #{
      prefix: '"ref:',
      length: 4,
      suffix: ''
    }
  }
```
