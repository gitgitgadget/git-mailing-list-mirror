From: Chris Patti <cpatti@gmail.com>
Subject: Bug: git-hooks documentation should note that if you are using
 git-daemon you will *not* see stdout and stderr output from hooks.
Date: Wed, 1 Sep 2010 13:05:41 -0400
Message-ID: <AANLkTi=H-W2zVcW_qK-BR8hRZvrv2EhY06Z_JfYYLFQR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 01 19:05:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oqql0-0002ZE-0M
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 19:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755479Ab0IARFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Sep 2010 13:05:44 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34278 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755154Ab0IARFm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 13:05:42 -0400
Received: by bwz11 with SMTP id 11so5488218bwz.19
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 10:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=W1L0GnDQcLG+rHFvC1F/Fp0tIoESyDDg9HRBsL4C+fw=;
        b=t9c4/Vy9snrS7CDyEDkKojHu6pLNwl44IqOf6I0avCc/m/HEayuL4OC8LCEZawhf7u
         Ewn/LDuiRXEhknMkL7NF1l/ttSNBHepO0l3xVjFTaf3HX9ay4jI5h8pDGfsKe4rsDh8K
         tpgAw5+uu2j+I9TdQzfQQA4iQxar0Q+2BaUGY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=pOf32e6lJ/4afxD4nJVJr8sZMqGLqdw+4scbmp3vCJA4y/bvgE4wle03PSXCOHF75c
         ZcPV3ygKDLJrmSDheHY4oWafXi03RMl1x9B/kq+tAIx/t1A0CfvX0TFyAsngBCqk7yz7
         DJCqza+1uFS56l8iM12jad7slAyNxUbENTlbo=
Received: by 10.204.76.138 with SMTP id c10mr3382593bkk.4.1283360741536; Wed,
 01 Sep 2010 10:05:41 -0700 (PDT)
Received: by 10.204.66.196 with HTTP; Wed, 1 Sep 2010 10:05:41 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155062>

How can I go about submitting a bug or a change request or a diff or
whatever to get this fixed please?

It's exceedingly confusing for someone just learning about hook
development, and wasted a few hours of my time I'd rather have spent
getting my hook running :)

Thanks!
-Chris


-- 
Christopher Patti - Geek At Large | GTalk: cpatti@gmail.com | AIM:
chrisfeohpatti | P: (260) 54PATTI
"Technology challenges art, art inspires technology." - John Lasseter, Pixar
