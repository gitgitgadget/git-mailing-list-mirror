From: "MichaelTiloDressel@t-online.de" <MichaelTiloDressel@t-online.de>
Subject: Re: pull into dirty working tree
Date: Wed, 13 Jun 2007 17:03:58 +0200
Message-ID: <1HyUO6-04z4yG0@fwd28.aul.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 13 17:04:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyUOJ-00077A-RS
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 17:04:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754887AbXFMPEJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 11:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757531AbXFMPEI
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 11:04:08 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:55220 "EHLO
	mailout03.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754887AbXFMPEH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jun 2007 11:04:07 -0400
Received: from fwd28.aul.t-online.de 
	by mailout03.sul.t-online.com with smtp 
	id 1HyUOD-0004RB-07; Wed, 13 Jun 2007 17:04:05 +0200
Received: from localhost (S8JIG6ZSQe+EJzvkoc0saS6UK84Frez24Zc7lXAQtNmyaBRpLy4I82@[172.20.101.250]) by fwd28.aul.t-online.de
	with esmtp id 1HyUO6-04z4yG0; Wed, 13 Jun 2007 17:03:58 +0200
X-UMS: email
X-Mailer: TOI Kommunikationscenter V7-7-2
X-ID: S8JIG6ZSQe+EJzvkoc0saS6UK84Frez24Zc7lXAQtNmyaBRpLy4I82@t-dialin.net
X-TOI-MSGID: aa7b71a7-ebb6-4c21-927d-315c2105f9af
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50072>

Hi,

why don't they just do a simple 
git commit -a
of their work before pulling?

That's different to cvs! Committing only affects the cloned repository.

I think one of the biggest advantages of git is the concept of everyone
working on a clone. So developers are not prevented from actually using
revision control just because they are afraid of disturbing others. They
don't until they e.g. push!


Cheers,
Michael
