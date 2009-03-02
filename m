From: Chris Velevitch <chris.velevitch@gmail.com>
Subject: VSS to git
Date: Tue, 3 Mar 2009 04:15:19 +1100
Message-ID: <b0a3bf780903020915g60d97b76pfdbbd60017625f0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 02 18:16:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeBl4-0007lA-Ci
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 18:16:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753248AbZCBRPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 12:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752711AbZCBRPW
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 12:15:22 -0500
Received: from rv-out-0506.google.com ([209.85.198.230]:12996 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752559AbZCBRPV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 12:15:21 -0500
Received: by rv-out-0506.google.com with SMTP id g37so2350708rvb.1
        for <git@vger.kernel.org>; Mon, 02 Mar 2009 09:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=mP+LiEzghPWY6m9CQa2agp/52QKXMp2UYKjBVL3wtLs=;
        b=jFkJZ7ew9YXl5nPKE20yYvlgcXUQe/s1/Yus/YE3BVJ7IT39cwHmrgnfa/uThZiMDd
         53BBSttmO1QKAQ2ZauqGOi9YJMmHPBwoY63lyANTsujE0k82y1iK2W5o+fjTjR7FH2k1
         ZqMqx6ajmm7bG1TLF++w3otqW0xgJ4oMx+1eg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=hWaZNAqEgRXg1kgOPW/Nc66f+6wxedfHq2avGGztWSL4MO8jeD9nsJvt9dDGK67oI4
         ayEgdKYNgAgKtpgCf9rV6uDfHdcm8sKgWGuR9rmKRjrwpF2W4ICtHB1vJE7l9AUipoOt
         kOzKYt/UyUGvwQ2vxchaghjClasIwiCJznU8U=
Received: by 10.141.50.11 with SMTP id c11mr3011811rvk.45.1236014119891; Mon, 
	02 Mar 2009 09:15:19 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111950>

I can't seem to find any utilities to convert a vss repository to git.
In the absence of such a tool, what is the best approach to converting
an vss repository to git?


Chris
--
Chris Velevitch
Manager - Adobe Platform Users Group, Sydney
m: 0415 469 095
www.apugs.org.au

Adobe Platform Users Group, Sydney
Mar meeting: Bzoo, FlashDevelop, Who's Doing What With AIR and Eclipse Tips
Date: Mon 30th Mar 6pm for 6:30 start
Details and RSVP on http://groups.adobe.com/posts/db02e98146
