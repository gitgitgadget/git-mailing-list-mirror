From: Matthias Nothhaft <matthias.nothhaft@googlemail.com>
Subject: submodules inside submodules?
Date: Tue, 17 Mar 2009 17:07:09 +0100
Message-ID: <978bdee00903170907g4cd02b01y971d378295787d50@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 17 17:15:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljbwg-0003as-5w
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 17:15:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755045AbZCQQNp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 12:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754808AbZCQQNo
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 12:13:44 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:56590 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754672AbZCQQNo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 12:13:44 -0400
X-Greylist: delayed 391 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Mar 2009 12:13:43 EDT
Received: by bwz17 with SMTP id 17so142220bwz.37
        for <git@vger.kernel.org>; Tue, 17 Mar 2009 09:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=6TQhPPlm+jisBHt3H6wGkhL7aXl/gKKc8uUurAvSO3Q=;
        b=DdGQ0AT5e3spoyGCr3m6Onm8tslLdKOwlm5PZ1C/SYF1i9SjbSKKx5pkM1bBEuHamX
         X9XGw64GE7w+RB34j/WoOeVPb+MNjvA63N+Z3Mro2VgTOW2rBfNGS8MQSp30yQ81dBSz
         oNchTU0HnYKEM1lsSCP6FaYE6f31GWxtZ9zo4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=Vv8tBWGxsWZHPJRuDh6WaHJsbw0XZPJrhXSAQdKMPBIkxlh/cxznqh68rQTbsM3rxn
         BnNquG/N5MTYqF/UQGFKIywRN4aT9Hdxg7dY/6Hwc4rKxYzNpDBsmZ0PlKSgcDMlb0jJ
         MuxWzM1cY2up/qZOGXNpr3tP6mxSE4ULYG328=
Received: by 10.204.55.200 with SMTP id v8mr55223bkg.54.1237306029881; Tue, 17 
	Mar 2009 09:07:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113492>

Hi,

can I put submodules into submodules? or is nesting submodules not possible?

regards,
Matthias
