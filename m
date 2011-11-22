From: Pascal Obry <pascal@obry.net>
Subject: Re: How to deal with mixed tree?
Date: Tue, 22 Nov 2011 18:29:54 +0100
Organization: Home - http://www.obry.net
Message-ID: <4ECBDC12.3050308@obry.net>
References: <CA+9ZNic-9U0nP1NGL0shUijnxdhaoEHwyxWM8rOzR2B6Qjq6zQ@mail.gmail.com> <4ECB8917.8010305@ira.uka.de> <4ECBAFB7.9040505@obry.net> <4ECBBAD4.6080206@ira.uka.de> <4ECBBDE3.3010904@obry.net> <4ECBCA4F.5090505@ira.uka.de>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Holger Hellmuth <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Nov 22 18:30:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSuAZ-0003EH-4x
	for gcvg-git-2@lo.gmane.org; Tue, 22 Nov 2011 18:30:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754379Ab1KVR37 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Nov 2011 12:29:59 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50645 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753290Ab1KVR37 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2011 12:29:59 -0500
Received: by fagn18 with SMTP id n18so669612fag.19
        for <git@vger.kernel.org>; Tue, 22 Nov 2011 09:29:57 -0800 (PST)
Received: by 10.204.128.199 with SMTP id l7mr9344474bks.27.1321982997526;
        Tue, 22 Nov 2011 09:29:57 -0800 (PST)
Received: from [192.168.0.100] (AVelizy-154-1-55-184.w83-199.abo.wanadoo.fr. [83.199.37.184])
        by mx.google.com with ESMTPS id hy13sm10701398bkc.0.2011.11.22.09.29.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 22 Nov 2011 09:29:56 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <4ECBCA4F.5090505@ira.uka.de>
X-Enigmail-Version: 1.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185800>


Holger,

> In my not-really-expert opinion no. At least git diff master has to show
> something because there obviously is a difference between what is in
> master (that you can't gitignore) and your branch (whether you ignore it
> or not).

I had come to the same conclusion. Sad, it would have been nice to have
an option to fully ignore a path in a repository.

Anyway, thanks a lot for your feedback.

Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
