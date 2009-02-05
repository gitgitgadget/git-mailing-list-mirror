From: Pascal Obry <pascal@obry.net>
Subject: Re: 026fa0d5ad Breaks installs with absolue $(gitexecdir) and 
	$(template_dir) variables using older GNU makes
Date: Thu, 5 Feb 2009 08:38:36 +0100
Message-ID: <a2633edd0902042338n25dc7be4vbb202d011eb4ad78@mail.gmail.com>
References: <4985E8E1.90303@gmail.com>
	 <7v63jpibe8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitzilla@gmail.com, Steffen Prohaska <prohaska@zib.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 08:40:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUyqD-0003JF-TC
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 08:40:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753180AbZBEHik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 02:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753136AbZBEHij
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 02:38:39 -0500
Received: from fk-out-0910.google.com ([209.85.128.187]:16352 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753113AbZBEHij (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 02:38:39 -0500
Received: by fk-out-0910.google.com with SMTP id f33so77251fkf.5
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 23:38:37 -0800 (PST)
Received: by 10.223.113.68 with SMTP id z4mr45817fap.72.1233819516808; Wed, 04 
	Feb 2009 23:38:36 -0800 (PST)
In-Reply-To: <7v63jpibe8.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108512>

I have just proposed a patch to fix this in another thread.

Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
