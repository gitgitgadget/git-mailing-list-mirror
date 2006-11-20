X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: [PATCH] Doc: Make comment about merging in tutorial.txt more clear
Date: Mon, 20 Nov 2006 21:29:41 +0100
Message-ID: <4d8e3fd30611201229y293aad01r1de2e4337a33c797@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_35913_23741145.1164054581753"
NNTP-Posting-Date: Mon, 20 Nov 2006 20:30:12 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=laC0P50SDncFe4nz01Z2rOuVRwXMzjy/ypF47wc+KJrHWL+PwMuI73fDMBUYzjVTLMOFai679VDCt3wF/B8MvgZKGxddE6EWJPaCqLM5o23qMjgbxGU1dIMqNaDsCTvEG0UFVTD0B3F2OSO/g4w3jtF3PsVFh8sDOrfGAfPe7DI=
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31936>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmFm1-0002Ce-WF for gcvg-git@gmane.org; Mon, 20 Nov
 2006 21:29:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966304AbWKTU3p (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 15:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966305AbWKTU3p
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 15:29:45 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:62699 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S966304AbWKTU3o
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 15:29:44 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1305969ugc for
 <git@vger.kernel.org>; Mon, 20 Nov 2006 12:29:42 -0800 (PST)
Received: by 10.78.118.19 with SMTP id q19mr5683771huc.1164054582033; Mon, 20
 Nov 2006 12:29:42 -0800 (PST)
Received: by 10.78.165.3 with HTTP; Mon, 20 Nov 2006 12:29:41 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

------=_Part_35913_23741145.1164054581753
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Rephrased a sentence in order to make more clear the concept of
pull . branch

Signed-off-by: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
---
 Documentation/tutorial.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index 554ee0a..646395d 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -141,7 +141,7 @@ $ git commit -a
 ------------------------------------------------

 at this point the two branches have diverged, with different changes
-made in each.  To merge the changes made in the two branches, run
+made in each.  To merge the changes did in experimental into master, run

 ------------------------------------------------
 $ git pull . experimental
--=20
1.4.4.ge3d4


--=20
Paolo
http://docs.google.com/View?docid=3Ddhbdhs7d_4hsxqc8
http://www.linkedin.com/pub/0/132/9a3
Non credo nelle otto del mattino. Per=F2 esistono. Le otto del mattino
sono l'incontrovertibile prova della presenza del male nel mondo.
Gli ultimi giorni, Andrew Masterson

------=_Part_35913_23741145.1164054581753
Content-Type: text/plain; name="0001-Doc-Make-comment-about-merging-in-tutorial.txt-more-clear.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0001-Doc-Make-comment-about-merging-in-tutorial.txt-more-clear.txt"
X-Attachment-Id: f_eurbzfqd

RnJvbSAxYTRlMDc4NTE1NTQ3YzM0NmI1ZDZlOGI3NGFiY2QyNGIyMGFjYjc4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQYW9sbyBDaWFycm9jY2hpIDxwYW9sby5jaWFycm9jY2hpQGdt
YWlsLmNvbT4KRGF0ZTogTW9uLCAyMCBOb3YgMjAwNiAyMToyNTo0NyArMDEwMAoKUmVwaHJhc2Vk
IGEgc2VudGVuY2UgaW4gb3JkZXIgdG8gbWFrZSBtb3JlIGNsZWFyIHRoZSBjb25jZXB0IG9mCnB1
bGwgLiBicmFuY2gKClNpZ25lZC1vZmYtYnk6IFBhb2xvIENpYXJyb2NjaGkgPHBhb2xvLmNpYXJy
b2NjaGlAZ21haWwuY29tPgotLS0KIERvY3VtZW50YXRpb24vdHV0b3JpYWwudHh0IHwgICAgMiAr
LQogMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi90dXRvcmlhbC50eHQgYi9Eb2N1bWVudGF0aW9uL3R1dG9y
aWFsLnR4dAppbmRleCA1NTRlZTBhLi42NDYzOTVkIDEwMDY0NAotLS0gYS9Eb2N1bWVudGF0aW9u
L3R1dG9yaWFsLnR4dAorKysgYi9Eb2N1bWVudGF0aW9uL3R1dG9yaWFsLnR4dApAQCAtMTQxLDcg
KzE0MSw3IEBAICQgZ2l0IGNvbW1pdCAtYQogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tCiAKIGF0IHRoaXMgcG9pbnQgdGhlIHR3byBicmFuY2hlcyBoYXZl
IGRpdmVyZ2VkLCB3aXRoIGRpZmZlcmVudCBjaGFuZ2VzCi1tYWRlIGluIGVhY2guICBUbyBtZXJn
ZSB0aGUgY2hhbmdlcyBtYWRlIGluIHRoZSB0d28gYnJhbmNoZXMsIHJ1bgorbWFkZSBpbiBlYWNo
LiAgVG8gbWVyZ2UgdGhlIGNoYW5nZXMgZGlkIGluIGV4cGVyaW1lbnRhbCBpbnRvIG1hc3Rlciwg
cnVuCiAKIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQog
JCBnaXQgcHVsbCAuIGV4cGVyaW1lbnRhbAotLSAKMS40LjQuZ2UzZDQKCg==
