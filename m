From: Albert Astals Cid <aacid@kde.org>
Subject: Fix wrong catalan translation
Date: Fri, 19 Dec 2014 11:38:22 +0100
Message-ID: <CACsWDtysnvwxzQCChVfZAF5fQMoT-qYZhC0cfj3Px2Eris5_ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11340cacdb19eb050a8f4e5e
To: alexhenrie24@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 19 11:38:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1ux2-0005hi-VX
	for gcvg-git-2@plane.gmane.org; Fri, 19 Dec 2014 11:38:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752456AbaLSKiZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2014 05:38:25 -0500
Received: from mail-la0-f42.google.com ([209.85.215.42]:48379 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098AbaLSKiY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2014 05:38:24 -0500
Received: by mail-la0-f42.google.com with SMTP id gd6so601786lab.1
        for <git@vger.kernel.org>; Fri, 19 Dec 2014 02:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=NInRw4H5CfLcmh89FZMwqTIrsaIAwVPk/yXNgh6P69E=;
        b=sXbnKzKFYMvewXDn/3kxjR7piH04wBPp1UhnlK2mMaaLNguZcVio9CdGE/BEZOKDVu
         YXJfFPkztGmkO9KVB9PVnkX0/M/VHOacHCpYa7oYcAh2Eq8Lr7j+kyK8u5p2Evh7YqN6
         heXYdmxwrz1QUiRRpTTuRQyOuvF4vp0WSP16WyHmKQ8Q9gH1gG9hwKyo4f0Jumw7EEJ6
         /3NHQn0RWL/PD7Ak3Puzmsz97/o5+mWLnNRYrljggyrxKTZfQMBxXBQvnUqULrcdbqbf
         QVi9Y7m6Mk133hvFt4NTpzv8fhsKy4kbCxH46lnnMq4VrtMOm2bZTSYU/bzmzCoIQLAZ
         XbqA==
X-Received: by 10.152.234.9 with SMTP id ua9mr7039477lac.44.1418985503127;
 Fri, 19 Dec 2014 02:38:23 -0800 (PST)
Received: by 10.112.10.193 with HTTP; Fri, 19 Dec 2014 02:38:22 -0800 (PST)
X-Google-Sender-Auth: OZNTbO74AUjalEyxzsCrTLdNeRU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261555>

--001a11340cacdb19eb050a8f4e5e
Content-Type: text/plain; charset=UTF-8

I'm not subscribed, please CC-me.

Hi, i'm attaching a fix for the Catalan translation were it seems some
Spanish sneaked in.

Cheers,
  Albert

P.S: Sending again since your list didn't like me sending this from
@yahoo mail server

--001a11340cacdb19eb050a8f4e5e
Content-Type: text/x-diff; charset=US-ASCII; 
	name="0001-Encima-is-not-a-word-in-Catalan.patch"
Content-Disposition: attachment; 
	filename="0001-Encima-is-not-a-word-in-Catalan.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i3vfbvax0

RnJvbSBlOGFlMmRiMGQwZjk3MzZiZDM1ZDkyYTY2ZmM0NmY1OWQ3NjJhZDk1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGJlcnQgQXN0YWxzIENpZCA8YWFjaWRAa2RlLm9yZz4KRGF0
ZTogRnJpLCAxOSBEZWMgMjAxNCAxMToxMzozNCArMDEwMApTdWJqZWN0OiBbUEFUQ0hdIEVuY2lt
YSBpcyBub3QgYSB3b3JkIGluIENhdGFsYW4KCi0tLQogcG8vY2EucG8gfCAyICstCiAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9wby9j
YS5wbyBiL3BvL2NhLnBvCmluZGV4IDFmZWEwNDcuLjEyOGY2M2EgMTAwNjQ0Ci0tLSBhL3BvL2Nh
LnBvCisrKyBiL3BvL2NhLnBvCkBAIC0xMDczMCw3ICsxMDczMCw3IEBAIG1zZ3N0ciAiQ2Fudmlz
IGRlICRtYiBhICRvbnRvOiIKIAogIzogZ2l0LXJlYmFzZS5zaDo2MTAKIG1zZ2lkICJGaXJzdCwg
cmV3aW5kaW5nIGhlYWQgdG8gcmVwbGF5IHlvdXIgd29yayBvbiB0b3Agb2YgaXQuLi4iCi1tc2dz
dHIgIlByaW1lciwgcmVib2JpbmFudCBlbCBjYXAgcGVyIGEgcmVwcm9kdWlyIGVsIHZvc3RyZSB0
cmViYWxsIGVuY2ltYS4uLiIKK21zZ3N0ciAiUHJpbWVyLCByZWJvYmluYW50IGVsIGNhcCBwZXIg
YSByZXByb2R1aXIgZWwgdm9zdHJlIHRyZWJhbGwgYSBzb2JyZS4uLiIKIAogIzogZ2l0LXJlYmFz
ZS5zaDo2MjAKICMsIHNoLWZvcm1hdAotLSAKMi4xLjMKCg==
--001a11340cacdb19eb050a8f4e5e--
