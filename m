Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A6661FCA0
	for <e@80x24.org>; Mon, 27 Mar 2017 19:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752108AbdC0Ttu (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 15:49:50 -0400
Received: from mout.gmx.net ([212.227.15.15]:55068 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751651AbdC0Ttr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 15:49:47 -0400
Received: from localhost.localdomain ([37.201.193.73]) by mail.gmx.com
 (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0LptId-1cGWK22as3-00fiUW; Mon, 27 Mar 2017 21:48:29 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.12.2
Date:   Mon, 27 Mar 2017 21:48:13 +0200
Message-Id: <20170327194813.6876-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.12.1.windows.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:2R2AhM9M47wcpCmcr6WfyYNHsHFpLCIAtE+quGzXTwLXoNMAoqT
 vufdrwikNkjXmkvqNfl6wDrYKvQrutf1GsqFkce+C9ucxTzTqUknnqigdId2ehS7zVBI+Op
 4OMwDXLTAxkZQwool1/Gr9ooQkfnAV9UZpOCbSBQmdhWZzg2bahT71PQzNJ9izD/vsakeea
 QsmGhkLZ2WLZ9JAxLkCVg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lkjGba1v6Pw=:lSuGLqTufFAPUXZ+cfqb9/
 nUB4Kt3eVqtaZvx8yaRdRz0YDnlAzYbBZzxUpJ+vQOz6YoG/Ejz3gBwo05nXv+NjM4b0+EJAf
 x03ck6wcMvHKXJjZs8ziDbvChtQu91ehXxR69jXuMstEBP/KjsXTxPeI2ax9pZHidqfJOn66S
 uuTP9WEHozEL56fDBI3VNg4h0ace/SA7P4dpdT3rZLeQ4us+UfF0rnl1kH6Aw5wOe+Ys1j0sM
 On9IUrrK/DytBHDwYAzijTX6yzKhn3zwgIJG1uGXyn8S2Be5R/o2RjonG9/Zap1mxSXyw+CiH
 eZO0LryFcgkY+eHoOOcM4Zwx7LENnv9bSaTknrthL4rcdPsDtEXBse5mBtLfALUFk09bXOGqN
 Zz6jNtMHs6V2EYbFSCti3+UsQATo5iV4fTo9K+A27ET3uVxdFKritN4wd0y/yrjDJtSAaWAS0
 /gP5Ui5kogy1Rqa/QiUfGczKzJvvXOeGRofiFUdFGE/8aEQtTzfBXlIdzwSgPZiI7eyc5UKEQ
 j980/95q0sj15/QSaQLg1vB1nheeR8d9wAqk0hnadCAy16RZMi0dYg/AtU/SqmTTSI27Abiux
 Ik/yTZ4UE+9NTvc4iAYUyKK3uUKHjDZ6xs07E/V/Q/pNe1cJoepTiWmQW4N8GAs2tkaGByE9F
 hknRm+zGHDOwc5jOZO9/9BH9ofPe1arAQzSJ7e7Q4UPGKYZQue/2KMLDHGWaN04e+boWxR2+c
 tUfjEif8U8TQ313tEQplPLCm4Y2PBBL1vMxZlHMbfVaGgoG1rif+26+HpJILzvhzA45a99TAu
 bmviG7R
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

It is my pleasure to announce that Git for Windows 2.12.2 is available from:

	https://git-for-windows.github.io/

Changes since Git for Windows v2.12.1 (March 21st 2017)

New Features

  * Comes with Git v2.12.2.
  * An earlier iteration of the changes speeding up the
    case-insensitive cache of file names was replaced by a new
    iteration.

Filename | SHA-256
-------- | -------
Git-2.12.2-64-bit.exe | 99492acd85bad097b5952ccfd5cb37658bf3301f5d8256f345dd10937ab07899
Git-2.12.2-32-bit.exe | f99a9c398ee352982477be39e723df3357c71f13f0697ec580cfee55419e5880
PortableGit-2.12.2-64-bit.7z.exe | 6a366a5b5702d24b401aba6b022d502b5f6597e00654075e491319878ba0a535
PortableGit-2.12.2-32-bit.7z.exe | 52c236fead982c31733e43fb7361a4982b2d1c0a54a011f68b074ec7f64436c3
MinGit-2.12.2-64-bit.zip | fcebf3ef4f7fe2bc852879eb77d2bd63af49bd274aa4c4d61c7b4a1fa76b830f
MinGit-2.12.2-32-bit.zip | 494e4fb629f8b05bc067e27aea86c45af2322a34730d5ff16609bed199e5954c
Git-2.12.2-64-bit.tar.bz2 | d91d2d6a6da99ceafc9b0749e619fa1db3387fe20dc0c9ad8e8c51e4a5cd9f37
Git-2.12.2-32-bit.tar.bz2 | e048e0082f07dbb7fed1107f78d0515c4d58916154f9c8f9591b482f52c25301

Ciao,
Johannes
