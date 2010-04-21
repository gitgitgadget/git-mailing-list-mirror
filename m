From: Eric Raymond <esr@thyrsus.com>
Subject: Re: CIA hook for contrib/
Date: Wed, 21 Apr 2010 17:55:10 -0400
Organization: Eric Conspiracy Secret Labs
Message-ID: <20100421215510.GB16643@thyrsus.com>
References: <20100327102632.GA5043@thyrsus.com>
 <20100421101002.GD3563@machine.or.cz>
 <20100421155149.GA11223@thyrsus.com>
 <20100421210427.GF3563@machine.or.cz>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Apr 21 23:55:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4ht9-0001xw-Ad
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 23:55:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756791Ab0DUVzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 17:55:12 -0400
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:60232
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753323Ab0DUVzL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 17:55:11 -0400
Received: by snark.thyrsus.com (Postfix, from userid 23)
	id 41961475FF1; Wed, 21 Apr 2010 17:55:10 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20100421210427.GF3563@machine.or.cz>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145464>

Petr Baudis <pasky@suse.cz>:
> Thanks for doing all the changes!

Thanks for the review.  You pushed me into doing two things I was
naggingly aware I ought to do but hadn't gotten around to: (1) XML-RPC
support from the Python version (alas, it's too hard from shell), and
(2) fixing the scripts so that they can be entirely informed by config
variables, no modifications or command-line switches required.

You can read about the current state of play at 

    <http://www.catb.org/esr/ciabot/>.

I've spent the last couple of hours testing
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
