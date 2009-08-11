From: Bruce Stephens <bruce.stephens@isode.com>
Subject: Re: rename/copy detection not working for git-log?
Date: Tue, 11 Aug 2009 14:42:55 +0100
Message-ID: <807hxasbz4.fsf@tiny.isode.net>
References: <20090811132144.GJ6327@morganstanley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 11 15:49:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MarjC-0001OH-Pt
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 15:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753429AbZHKNtF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 09:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753118AbZHKNtF
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 09:49:05 -0400
Received: from rufus.isode.com ([62.3.217.251]:50805 "EHLO rufus.isode.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752553AbZHKNtE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 09:49:04 -0400
X-Greylist: delayed 363 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Aug 2009 09:49:04 EDT
Received: from tiny.isode.net (shiny.isode.com [62.3.217.250]) 
          by rufus.isode.com (smtp internal) via TCP with SMTP 
          id <SoF1XwB9YUud@rufus.isode.com> for <git@vger.kernel.org>;
          Tue, 11 Aug 2009 14:42:55 +0100
Received: by tiny.isode.net (sSMTP sendmail emulation);
          Tue, 11 Aug 2009 14:42:55 +0100
X-Hashcash: 1:20:090811:git@vger.kernel.org::wudnQ+xBKX+1j9YY:0000000000000000000000000000000000000000001Ee+
In-Reply-To: <20090811132144.GJ6327@morganstanley.com> (Kevin Green's message
	of "Tue, 11 Aug 2009 09:21:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125558>

Kevin Green <Kevin.T.Green@morganstanley.com> writes:

[...]

> What am I missing?

I'd guess --follow
