From: Eli Barzilay <eli@barzilay.org>
Subject: Re: diff without num-stat
Date: Fri, 23 Apr 2010 15:45:23 -0400
Message-ID: <19409.63699.647720.327239@winooski.ccs.neu.edu>
References: <19408.40250.102191.314496@winooski.ccs.neu.edu>
	<4BD156F8.5090307@drmicha.warpmail.net>
	<7vwrvyzfr3.fsf@alter.siamese.dyndns.org>
	<19409.54647.62163.893635@winooski.ccs.neu.edu>
	<7vaasuvz6r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 23 21:45:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5Oov-0003He-Ke
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 21:45:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756251Ab0DWTpa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Apr 2010 15:45:30 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:38128 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756053Ab0DWTp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 15:45:28 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1O5OoV-0008U1-LP; Fri, 23 Apr 2010 15:45:23 -0400
In-Reply-To: <7vaasuvz6r.fsf@alter.siamese.dyndns.org>
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145636>

On Apr 23, Junio C Hamano wrote:
> Eli Barzilay <eli@barzilay.org> writes:
> 
> > Well, the reason is to have an easy-to-glance-over summary of
> > changes for push notification emails.  I didn't realize that the
> > intention of --stat was to be completely compatible with
> > `diffstat'.
> 
> I think you have it somewhat backwards.
> 
> Being the same as normal diffstat output that people are familiar with,
> the output makes it "an easy-to-glance-over summary of changes" whereever
> it is used, be it in a notification e-mail or from interactive command
> output.

(That's true only if the intended audience of these notifications are
people who are familiar with diffstat output.)

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
