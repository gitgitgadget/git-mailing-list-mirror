From: "Neshama Parhoti" <pneshama@gmail.com>
Subject: no --dry-run to git-pull ?
Date: Fri, 4 Jul 2008 16:56:27 +0300
Message-ID: <912ec82a0807040656y1c48cba8m6f9981f6bb97b36a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 04 15:57:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KElmw-0002lG-0e
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 15:57:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753659AbYGDN43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 09:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753662AbYGDN43
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 09:56:29 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:16442 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753581AbYGDN42 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 09:56:28 -0400
Received: by wr-out-0506.google.com with SMTP id 69so894191wri.5
        for <git@vger.kernel.org>; Fri, 04 Jul 2008 06:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=HVqfegC1s4Ng68J3ER1qhTFXjYjs6s0LBU1my0NszKw=;
        b=bROjXUBxgN1eK1N9EgU2kdOr0Ch7mUr1vWrKDycWCnuITbnWHL2nUNueR+5XsyLcHa
         Xf419/L6QXbTAMNRYI8oB6vmKVGbnh0V8ap76G+Sc0RywkIL2wz/NppcXkYelhgmn+LD
         UBdwBvlA59x82SsO3AmySjlSGqxNpINgTNO/A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=JVrgOnB7cWXw/PtU2biN1ddcpnohVW4CS38Zn7X5kGTu45yVCxAHwSJY4vq5xFcNJu
         eapk9zbtr/zHGvWNWE6tomt7NN3ZDVsfdAc0XDjvnbuYY8gObXNDqrjSSxYPcNJSmd7t
         DHiQSB1pARG9ZuBcC4P/q30AJriXIZ1BkV3SI=
Received: by 10.100.197.7 with SMTP id u7mr785628anf.27.1215179787482;
        Fri, 04 Jul 2008 06:56:27 -0700 (PDT)
Received: by 10.100.134.20 with HTTP; Fri, 4 Jul 2008 06:56:27 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87394>

Hi,

Isn't there a way to do a --dry-run with git-pull ?

Thank you,
pnesh
