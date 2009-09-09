From: Bruce Stephens <bruce.stephens@isode.com>
Subject: Re: Funktion like "last commit time" in SVN
Date: Wed, 09 Sep 2009 15:53:46 +0100
Message-ID: <80tyzcjhj9.fsf@tiny.isode.net>
References: <OFDE6223D3.9B58FBF2-ONC125762C.00502B15-C125762C.005096F0@EISENMANN.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Benjamin.Glasebach@eisenmann.com
X-From: git-owner@vger.kernel.org Wed Sep 09 16:54:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlOYW-00081k-Vd
	for gcvg-git-2@lo.gmane.org; Wed, 09 Sep 2009 16:53:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596AbZIIOxr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2009 10:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752542AbZIIOxq
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Sep 2009 10:53:46 -0400
Received: from rufus.isode.com ([62.3.217.251]:38272 "EHLO rufus.isode.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752523AbZIIOxq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2009 10:53:46 -0400
Received: from tiny.isode.net (shiny.isode.com [62.3.217.250]) 
          by rufus.isode.com (smtp internal) via TCP with SMTP 
          id <SqfBewB9YQcl@rufus.isode.com>; Wed, 9 Sep 2009 15:53:47 +0100
Received: by tiny.isode.net (sSMTP sendmail emulation);
          Wed, 09 Sep 2009 15:53:46 +0100
X-Hashcash: 1:20:090909:benjamin.glasebach@eisenmann.com::Xz6JnTQgC6NTe3M8:000000000000000000000000000000iYc
X-Hashcash: 1:20:090909:git@vger.kernel.org::iGiaQb0jF5PYlsIL:000000000000000000000000000000000000000000BQqS
In-Reply-To: <OFDE6223D3.9B58FBF2-ONC125762C.00502B15-C125762C.005096F0@EISENMANN.DE>
	(Benjamin Glasebach's message of "Wed, 9 Sep 2009 16:40:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128069>

Benjamin.Glasebach@eisenmann.com writes:

> does GIT have any Funktion "last commit time" like in SVN?
> So that the create and change-time don't change.

I don't know exactly what SVN does.  Does this help,
<http://git.or.cz/gitwiki/ExampleScripts#Settingthetimestampsofthefilestothecommittimestampofthecommitwhichlasttouchedthem>?

[...]
