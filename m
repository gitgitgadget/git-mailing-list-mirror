From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: Problem setting up a shared git repository
Date: Fri, 6 Sep 2013 14:06:33 +0400
Message-ID: <20130906140633.8b113079bf45e8a5307a1d11@domain007.com>
References: <1378417432.91149.YahooMailNeo@web161803.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Eyal Zinder <ezinder@yahoo.com>
X-From: git-owner@vger.kernel.org Fri Sep 06 12:17:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHt6b-0006vm-5u
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 12:17:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038Ab3IFKR3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Sep 2013 06:17:29 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:54180 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887Ab3IFKR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 06:17:28 -0400
X-Greylist: delayed 653 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Sep 2013 06:17:28 EDT
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id r86A6WUV017751;
	Fri, 6 Sep 2013 14:06:33 +0400
In-Reply-To: <1378417432.91149.YahooMailNeo@web161803.mail.bf1.yahoo.com>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234032>

On Thu, 5 Sep 2013 14:43:52 -0700 (PDT)
Eyal Zinder <ezinder@yahoo.com> wrote:

[...]
> The problem I faced later on was in parallel development, when
> changes were made to a file in one repository, and at the same time
> other changes made to the same file in another repository.. =9AI
> couldh't push changes from the dev\foo to prod\foo or to origin..
[...]

Did Git tell you the push failed because of "non-fast-forward update"?
