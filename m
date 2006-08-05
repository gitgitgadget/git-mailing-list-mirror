From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/9] gitweb: First patch corrected and split into separate patches
Date: Sat, 05 Aug 2006 12:51:41 +0200
Organization: At home
Message-ID: <44d47813.36251c31.2553.3cf7@mx.gmail.com>
References: <200608050036.06490.jnareb@gmail.com> <200608050038.20534.jnareb@gmail.com> <7vu04sghr0.fsf@assigned-by-dhcp.cox.net> <eb0oiu$sj1$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Aug 05 12:51:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9JkH-00078Y-R8
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 12:51:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbWHEKvB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 06:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbWHEKvB
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 06:51:01 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:33529 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751459AbWHEKvA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Aug 2006 06:51:00 -0400
Received: by nf-out-0910.google.com with SMTP id k26so168756nfc
        for <git@vger.kernel.org>; Sat, 05 Aug 2006 03:50:59 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:subject:to:mail-copies-to:date:references:lines:organization:user-agent:mime-version:content-type:content-transfer-encoding:message-id;
        b=aOqK9fzp+PgJVlUKLMvIEL6xUZDkzipWszEAoHVzl909MYic1iSFRx7rfzP02StiG1hCizPC708UCUeTIlf/HHvPmsSwP9piVswdbkYJZRCc0lltle34BFzdboMfvqnfAViwVTaAN7nfdZaDMVgCX3QQcz5rcxhzIWQ7v0Hdvns=
Received: by 10.49.8.1 with SMTP id l1mr6499891nfi;
        Sat, 05 Aug 2006 03:50:59 -0700 (PDT)
Received: from host-81-190-31-92.torun.mm.pl ( [81.190.31.92])
        by mx.gmail.com with ESMTP id p20sm3521300nfc.2006.08.05.03.50.58;
        Sat, 05 Aug 2006 03:50:59 -0700 (PDT)
To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24898>

Jakub Narebski wrote:

> I'm sorry for unrelated changes (the commit could be probably split 
> into four).

This series splits unrelated changes into separate patches, does not add
controversial adding (unescaped) value of invalid/errorneous parameter to
error message, and correct errors noticed during creation of this series.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
