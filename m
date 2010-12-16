From: Leo <sdl.web@gmail.com>
Subject: why the html and man versions of git-diff are different?
Date: Thu, 16 Dec 2010 21:43:45 +0000
Message-ID: <m139px2y26.fsf@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 16 22:50:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTLiF-0001Dp-Jw
	for gcvg-git-2@lo.gmane.org; Thu, 16 Dec 2010 22:50:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757293Ab0LPVuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 16:50:06 -0500
Received: from lo.gmane.org ([80.91.229.12]:34727 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754887Ab0LPVuF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Dec 2010 16:50:05 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PTLi8-00017n-8t
	for git@vger.kernel.org; Thu, 16 Dec 2010 22:50:04 +0100
Received: from cpc1-cmbg13-0-0-cust596.5-4.cable.virginmedia.com ([86.9.122.85])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 16 Dec 2010 22:50:04 +0100
Received: from sdl.web by cpc1-cmbg13-0-0-cust596.5-4.cable.virginmedia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 16 Dec 2010 22:50:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: cpc1-cmbg13-0-0-cust596.5-4.cable.virginmedia.com
Face: iVBORw0KGgoAAAANSUhEUgAAACgAAAAoBAMAAAB+0KVeAAAAGFBMVEUzRVhbQj4eZqO6SjnT
 eWpxnMetm5b6/PmidmqrAAAAAWJLR0QAiAUdSAAAAAlwSFlzAAALEwAACxMBAJqcGAAAAAd0SU1F
 B9cBBwMLBfKABCMAAAFoSURBVCjPtZI9a8MwEIaFoc7aYDdelQMna0Em3tsSr0XUeE2Q6a22a+v+
 fk8fSSBkbDUI6dHpfe9OEvRgiD+ApqKPJgJeB6iUUXWESjUe/ig38AJrhqqvaU2nTIXbNvOQ40fe
 qdry4kyGoVWsfCQalXpHnJGM01wjWdYbMlXNFdsZDO69m9aqNqxEJqTEgbM5OF7wlEfIoll1Ked4
 LbM5X2EdILLokEdmI8z7g5cKED0cuTC930TYhy7ZDekkXVGw/L60TguJePPxcJF48lpsSUWEA/Ju
 jGFNgJOXc4Hz7TmAdBeu5Ve4AEjOi2/2jfd3cAJZ+IbNrvdjgBZY01b+HTuG3cLws6BJZqVOj/pp
 T0OqVwx3rFq+QmJwx3loK5JSLEhDIt62+mtC2C+SrAUxEbV6C6v2BRbd6pILBKFpepKZJHgGgrKF
 sptSUUoczpwg2pQ7ZH1tgs0ou/917mzz6Cs2//C978cv5l07L02orIEAAAAASUVORK5CYII=
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2.91 (Mac OS X 10.6.5)
Cancel-Lock: sha1:Ebu6yyxUrQ8wKl+0dY9vp92WQTU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163819>

Hello,

I compared the html version of git-diff found in
http://www.kernel.org/pub/software/scm/git/docs/git-diff.html and the
man version from
http://kernel.org/pub/software/scm/git/git-manpages-1.7.3.4.tar.bz2

The man version says gitrevisions(1), which is incorrect since it is in
man7.

Leo

-- 
Oracle is the new evil
