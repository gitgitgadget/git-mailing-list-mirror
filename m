From: Junio C Hamano <junkio@cox.net>
Subject: Re: Deprecate --cache.* ?
Date: Tue, 15 Nov 2005 22:06:48 -0800
Message-ID: <7vsltxazyf.fsf@assigned-by-dhcp.cox.net>
References: <437A5F08.7020908@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 07:23:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcGRk-000410-B5
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 07:07:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbVKPGG4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 16 Nov 2005 01:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030185AbVKPGG4
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 01:06:56 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:49065 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1030186AbVKPGGz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Nov 2005 01:06:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051116060652.YZOB25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 16 Nov 2005 01:06:52 -0500
To: Lukas =?iso-8859-1?Q?Sandstr=F6m?= <lukass@etek.chalmers.se>
In-Reply-To: <437A5F08.7020908@etek.chalmers.se> (Lukas =?iso-8859-1?Q?San?=
 =?iso-8859-1?Q?dstr=F6m's?= message
	of "Tue, 15 Nov 2005 23:19:52 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12004>

Lukas Sandstr=F6m <lukass@etek.chalmers.se> writes:

> Backward compability could be ensured by having both versions of the =
flags
> around for a while and issuing a warning when the old form is used.
>
> Good idea? Bad? Stupid? Do we want to keep "cache" around?

I agree that may be a logical move, with proper b/c slack, but I
am not _so_ enthused about this...
