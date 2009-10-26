From: eschvoca <eschvoca@gmail.com>
Subject: git rebase -i <first_commit_in_repository>
Date: Mon, 26 Oct 2009 13:14:47 -0400
Message-ID: <2b05065b0910261014t4eb93952oc804bcd01b339a84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 26 18:21:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2TGR-0001QZ-Sx
	for gcvg-git-2@lo.gmane.org; Mon, 26 Oct 2009 18:21:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753993AbZJZRVi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2009 13:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753759AbZJZRVi
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 13:21:38 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:40594 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646AbZJZRVh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2009 13:21:37 -0400
Received: by fxm18 with SMTP id 18so12267355fxm.37
        for <git@vger.kernel.org>; Mon, 26 Oct 2009 10:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=6YLuLaku5rF38c4t36Te8X3F1ZC18OElPtD5BIhLJWw=;
        b=DeYU628T/+6iSsjBGb1g2H7QM0InFa1AT4yqxt7DqXxXdAyeT+6dcBWy8dNnxVk8S4
         2MPua2mS2V4CK1m5MyJaFUD3OlkzCIWNWkIqJEBPioPlHOc6vXnD71TODdPPhS0kBWfA
         fCRbxML4tfc0X12dl985TgyH9BF5daVq9Fvos=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=RWeA+9STitMN09ptMX0xPNLcCiMAzED3GcQjnQxXgAiYGe16EizwSMWlBqb01h19GV
         sNudwxrL33EyfHUeMUNdxAUbizVlcgca6fLa3VQ/e2AxfsxMcIklyMQdGJigcdHIULia
         SfeNi1fL4s75f/IwSn+yEDij1Y9k3o9ap2Htg=
Received: by 10.103.122.37 with SMTP id z37mr2596826mum.86.1256577287868; Mon, 
	26 Oct 2009 10:14:47 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131255>

Hi,

Is there a way to rewrite history, including the first commit.  It
seems that the first commit can not be modified with a rebase.

Cheers.
