From: "MichaelTiloDressel@t-online.de" <MichaelTiloDressel@t-online.de>
Subject: Re: /usr/bin/cg-log: line 361: echo: write error: Broken pipe
Date: Wed, 13 Jun 2007 12:18:54 +0200
Message-ID: <1HyPwE-2EAFYu0@fwd28.aul.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 13 12:19:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyPwf-0001mr-40
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 12:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756837AbXFMKTU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 06:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756819AbXFMKTT
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 06:19:19 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:37623 "EHLO
	mailout10.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756635AbXFMKTT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jun 2007 06:19:19 -0400
Received: from fwd28.aul.t-online.de 
	by mailout10.sul.t-online.com with smtp 
	id 1HyPwb-0005HN-0A; Wed, 13 Jun 2007 12:19:17 +0200
Received: from localhost (TWIC2+ZQ8epUsPbXobDSh5t8rJtlX9PwxoGtE7pgkbg2WL6654RgUz@[172.20.101.250]) by fwd28.aul.t-online.de
	with esmtp id 1HyPwE-2EAFYu0; Wed, 13 Jun 2007 12:18:54 +0200
X-UMS: email
X-Mailer: TOI Kommunikationscenter V7-7-2
X-ID: TWIC2+ZQ8epUsPbXobDSh5t8rJtlX9PwxoGtE7pgkbg2WL6654RgUz@t-dialin.net
X-TOI-MSGID: b9c21cc9-2661-49bb-a5a8-dfcee1609198
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50041>

Hi,

it was just me beeing stupid, not reading the man page. cg-log -M shows
the merge too.
And the pipe error may be due to less.

Cheers,
Michael
