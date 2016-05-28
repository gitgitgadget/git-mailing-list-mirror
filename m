From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH v8 0/9] connect: various cleanups
Date: Sat, 28 May 2016 14:33:54 +0900
Message-ID: <20160528053354.GA3860@glandium.org>
References: <20160527022756.22904-1-mh@glandium.org>
 <a6f4bf06-a52b-dcdf-9407-0c03b8b1dfe1@web.de>
 <20160527215943.GA21018@glandium.org>
 <5071966e-6bce-fa91-8837-81cb3c9157f7@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: Torsten =?iso-8859-15?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat May 28 07:34:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6WtB-0008SV-Vl
	for gcvg-git-2@plane.gmane.org; Sat, 28 May 2016 07:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbcE1FeL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 May 2016 01:34:11 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:50800 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750814AbcE1FeK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2016 01:34:10 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1b6Wsk-0001Bm-UJ; Sat, 28 May 2016 14:33:54 +0900
Content-Disposition: inline
In-Reply-To: <5071966e-6bce-fa91-8837-81cb3c9157f7@web.de>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295801>

On Sat, May 28, 2016 at 07:02:01AM +0200, Torsten B=F6gershausen wrote:
> On 27.05.16 23:59, Mike Hommey wrote:
> > On Fri, May 27, 2016 at 04:24:20PM +0200, Torsten B=F6gershausen wr=
ote:
> >> On 27.05.16 04:27, Mike Hommey wrote:
> >>> Changes from v7:
> >>> - Fixed comments.
> >>>
> >>> Mike Hommey (9):
> All in all, a great improvement.
> 2 things left.
> - The comment about [] is now stale, isn't it ?

No, it's still valid at this point, that's what the 2nd argument to
host_end (0) does.

Mike
