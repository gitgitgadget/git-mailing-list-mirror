From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH 2/3] Introduce rename factorization in diffcore.
Date: Sat, 8 Nov 2008 01:50:19 +0100
Message-ID: <20081108005019.GL5158@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20081101220319.1116.50509.stgit@gandelf.nowhere.earth> <7vy6zwgx3i.fsf@gitster.siamese.dyndns.org> <20081107193957.GI5158@nan92-1-81-57-214-146.fbx.proxad.net> <7v3ai3gugt.fsf@gitster.siamese.dyndns.org> <20081107203952.GJ5158@nan92-1-81-57-214-146.fbx.proxad.net> <7vskq3fdgz.fsf@gitster.siamese.dyndns.org> <20081107221224.GK5158@nan92-1-81-57-214-146.fbx.proxad.net> <7vhc6jdrvs.fsf@gitster.siamese.dyndns.org> <20081108002952.GC4030@nan92-1-81-57-214-146.fbx.proxad.net> <7vd4h7dowd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 08 01:52:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kyc3S-0004U8-No
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 01:51:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752551AbYKHAum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 19:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752542AbYKHAum
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 19:50:42 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:50178 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752041AbYKHAul (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 19:50:41 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 4360A1AB2B1;
	Sat,  8 Nov 2008 01:50:40 +0100 (CET)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 266E71AB2AB;
	Sat,  8 Nov 2008 01:50:40 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 1ED701F072; Sat,  8 Nov 2008 01:50:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vd4h7dowd.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100370>

On Fri, Nov 07, 2008 at 04:47:46PM -0800, Junio C Hamano wrote:
> Yann Dirson <ydirson@altern.org> writes:
> 
> > ...  Commands
> > for saving/mailing patches could issue a bold warning if the user
> > specifies the for-human-viewing flag.
> 
> If it is a warning to the user who produces the patch, and not but a
> warning in the patch text for the user who receives it, it is not useful.

OK to get everyone warned :)
