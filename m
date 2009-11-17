From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] GIT 1.6.5.3
Date: Tue, 17 Nov 2009 02:25:13 -0800 (PST)
Message-ID: <m3fx8dcuug.fsf@localhost.localdomain>
References: <7v4ootltzm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 11:30:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NALKT-0005gj-48
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 11:30:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753890AbZKQKaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 05:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753612AbZKQKaV
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 05:30:21 -0500
Received: from mail-bw0-f223.google.com ([209.85.218.223]:54391 "EHLO
	mail-bw0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753549AbZKQKaU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 05:30:20 -0500
X-Greylist: delayed 310 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Nov 2009 05:30:20 EST
Received: by bwz23 with SMTP id 23so6779023bwz.29
        for <git@vger.kernel.org>; Tue, 17 Nov 2009 02:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=AM4b0lpXEhR2nmabrDdTfmLw7/HtdeFfUzBShrBMXCA=;
        b=oF00V2cyib+av2F0+uVKY+6npiUkZA8HNIL/Ia4RjK7feqoEZNxWQeKnwb3TchPkB3
         9wFrIg6CvG/YQgxxdZx7u5CjoF1nntp1SEEorZvrMQCaCL9bwN0N3MwWoPMKOAuikKiV
         sEeXgOt8RggD8HWVlDmykoDrDGfJn95n6UhdY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=YtUkbZ1ud4PpRwpsXqr0C5zT31mJxb0/IidqBccu7jHN7HJEs1J+40pbz1sA/pSzRu
         J7ps8Q8U1jz0jNclaeW8CMDa3AsQ2zWwwdQP/1RfIXZC1YjKu6egqLQdZWOKw5x58ROd
         zZ5qSjz23S3SLMuBwDzVa3LS3JJ4XoSu0dnfw=
Received: by 10.204.3.14 with SMTP id 14mr11140621bkl.128.1258453514345;
        Tue, 17 Nov 2009 02:25:14 -0800 (PST)
Received: from localhost.localdomain (abwu104.neoplus.adsl.tpnet.pl [83.8.244.104])
        by mx.google.com with ESMTPS id 12sm5947321fks.8.2009.11.17.02.25.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Nov 2009 02:25:13 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id nAHAOecC016861;
	Tue, 17 Nov 2009 11:24:50 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id nAHAOOrL016854;
	Tue, 17 Nov 2009 11:24:24 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7v4ootltzm.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133086>

Junio C Hamano <gitster@pobox.com> writes:

> The RPM binary packages for a few architectures are found in:
> 
>   RPMS/$arch/git-*-1.6.5.3-1.fc9.$arch.rpm	(RPM)

It's RPMS/$arch/git-*-1.6.5.3-1.fc11.$arch.rpm	(RPM)
 
> Git v1.6.5.3 Release Notes
> ==========================
> 
> Fixes since v1.6.5.2
> --------------------

>  * Packages generated on newer FC were unreadable by older versions of
>    RPM as the new default is to use stronger hash.

Thanks.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
