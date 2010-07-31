From: Walter Bright <boost@digitalmars.com>
Subject: Re: noob user, want checkins to all be forced to LF terminated lines
Date: Sat, 31 Jul 2010 13:51:15 -0700
Organization: Digital Mars
Message-ID: <i322ca$niu$1@dough.gmane.org>
References: <i308gl$v6p$1@dough.gmane.org> <20100731044957.GA8920@burratino> <i30bg7$50k$1@dough.gmane.org> <20100731054437.GD14425@burratino> <i30g2s$dpt$1@dough.gmane.org> <20100731203820.GA1773@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 31 22:51:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfJ22-0001FZ-EQ
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 22:51:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756470Ab0GaUvi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jul 2010 16:51:38 -0400
Received: from lo.gmane.org ([80.91.229.12]:32958 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756146Ab0GaUve (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 16:51:34 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OfJ1m-0001Au-Rf
	for git@vger.kernel.org; Sat, 31 Jul 2010 22:51:30 +0200
Received: from c-24-16-56-60.hsd1.wa.comcast.net ([24.16.56.60])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 22:51:30 +0200
Received: from boost by c-24-16-56-60.hsd1.wa.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 22:51:30 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-16-56-60.hsd1.wa.comcast.net
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <20100731203820.GA1773@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152338>

Jonathan Nieder wrote:
> Anyway, feel free to ignore this advice.  "cp -a" works fine already
> and is sometimes just the right thing to do.

Thanks for the info. I am so thoroughly fed up with applications that store 
their data in ways that cannot be backed up / restored with straightforward file 
tree copying. I don't know why anyone else puts up with that, either.
