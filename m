From: Yann Dirson <ydirson@free.fr>
Subject: Re: What's cooking in git.git (Dec 2010, #01; Sat, 4)
Date: Sun, 5 Dec 2010 11:13:33 +0100
Message-ID: <20101205101333.GA7466@home.lan>
References: <7voc90wx36.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 05 11:13:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPBbK-0003Ff-Cz
	for gcvg-git-2@lo.gmane.org; Sun, 05 Dec 2010 11:13:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753769Ab0LEKNo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Dec 2010 05:13:44 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:60806 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752734Ab0LEKNo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Dec 2010 05:13:44 -0500
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 3E550D48213;
	Sun,  5 Dec 2010 11:13:34 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PPBb3-0000nC-UU; Sun, 05 Dec 2010 11:13:33 +0100
Content-Disposition: inline
In-Reply-To: <7voc90wx36.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162934>

On Sat, Dec 04, 2010 at 10:30:21PM -0800, Junio C Hamano wrote:
> * kb/diff-C-M-synonym (2010-11-29) 1 commit
>  - diff: add --detect-copies-harder as a synonym for --find-copies-harder
> 
> Will merge to 'next' soon.

If we go this way, don't we want to deprecate --find-copies-harder as well ?
