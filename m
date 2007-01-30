From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: blameview and file line number
Date: Tue, 30 Jan 2007 12:55:44 +0530
Message-ID: <cc723f590701292325k1c85d9edgb9e72ae380fcaad7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_159050_477232.1170141944702"
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 30 08:25:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBnNF-0000kc-KJ
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 08:25:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965410AbXA3HZq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 02:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965411AbXA3HZq
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 02:25:46 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:15139 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965410AbXA3HZq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 02:25:46 -0500
Received: by nf-out-0910.google.com with SMTP id o25so124242nfa
        for <git@vger.kernel.org>; Mon, 29 Jan 2007 23:25:45 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=TPNXoDmWOF/pH1zjw7ianm9dBOkpE0hcy3vwxdc+w5Aihna5SXk2ULAvJa4xP/8DcyGKbG1x9LdV0XeSekLDVAmeLNhusAdc/5dZ00UKYZsdCiCQY7z2GDatRxIieop9vZVsJR2SiNieFTmpvqm796dN9AJPJFvb5efneiqp438=
Received: by 10.49.8.1 with SMTP id l1mr347088nfi.1170141944728;
        Mon, 29 Jan 2007 23:25:44 -0800 (PST)
Received: by 10.48.210.15 with HTTP; Mon, 29 Jan 2007 23:25:44 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38127>

------=_Part_159050_477232.1170141944702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Is it a typo or intentional ? I found the blameview output confusing.

-aneesh

------=_Part_159050_477232.1170141944702
Content-Type: text/x-patch; name=blameview.diff; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_exk07ng3
Content-Disposition: attachment; filename="blameview.diff"

ZGlmZiAtLWdpdCBhL2NvbnRyaWIvYmxhbWV2aWV3L2JsYW1ldmlldy5wZXJsIGIvY29udHJpYi9i
bGFtZXZpZXcvYmxhbWV2aWV3LnBlcmwKaW5kZXggYTU1Zjc5OS4uZThiY2IxYiAxMDA3NTUKLS0t
IGEvY29udHJpYi9ibGFtZXZpZXcvYmxhbWV2aWV3LnBlcmwKKysrIGIvY29udHJpYi9ibGFtZXZp
ZXcvYmxhbWV2aWV3LnBlcmwKQEAgLTYyLDcgKzYyLDcgQEAgc3ViIGZsdXNoX2JsYW1lX2xpbmUg
ewogCWZvcihteSAkaSA9IDA7ICRpIDwgJGNudDsgJGkrKykgewogCQlAeyRmaWxldmlldy0+e2Rh
dGF9LT5bJGxubyskaS0xXX1bMCwxLDJdID0KIAkJICAgIChzdWJzdHIoJGNvbW1pdCwgMCwgOCks
ICRpbmZvLAotCQkgICAgICRmaWxlbmFtZSAuICc6JyAuICgkc19sbm8rJGkpKTsKKwkJICAgICAk
ZmlsZW5hbWUgLiAnOicgLiAoJGxubyskaSkpOwogCX0KIH0KIAo=
------=_Part_159050_477232.1170141944702--
