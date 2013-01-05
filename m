From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: [PATCH] git-fast-import(1): remove duplicate "--done" option
Date: Sat, 5 Jan 2013 11:26:20 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20130105162619.GA15757@thyrsus.com>
References: <20130105160652.GE6440@serenity.lan>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sat Jan 05 17:26:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrWa9-0008BT-Ju
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 17:26:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755826Ab3AEQ0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 11:26:31 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:54125
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755781Ab3AEQ0a (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 11:26:30 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 6A8524044B; Sat,  5 Jan 2013 11:26:20 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20130105160652.GE6440@serenity.lan>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212703>

John Keeping <john@keeping.me.uk>:
> I'm guessing that the reason the option was documented again (in commit
> 3266de10) is because the options are not in an obvious order.  There
> does seem to be some grouping of the options by type, but without
> subheadings I wonder if it would make more sense to just put them all in
> alphabetical order?

+1

This duplication originated with me. I'll apologize with a 
reordering patch.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
