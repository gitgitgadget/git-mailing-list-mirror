From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: What's cooking in git.git (May 2012, #04; Fri, 11)
Date: Mon, 14 May 2012 15:40:46 +0200
Message-ID: <20120514134046.GA2757@goldbirke>
References: <7vvck2js91.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 14 15:41:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STvWM-0001Oz-3r
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 15:41:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754608Ab2ENNkw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 May 2012 09:40:52 -0400
Received: from ex-e-2.perimeter.fzi.de ([141.21.8.251]:34358 "EHLO
	ex-e-2.perimeter.fzi.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754517Ab2ENNkt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2012 09:40:49 -0400
Received: from ex-ca-ht-1.fzi.de (141.21.32.98) by ex-e-2.perimeter.fzi.de
 (141.21.8.251) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 14 May
 2012 15:40:44 +0200
Received: from localhost6.localdomain6 (141.21.50.31) by ex-ca-ht-1.fzi.de
 (141.21.32.98) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 14 May
 2012 15:40:46 +0200
Content-Disposition: inline
In-Reply-To: <7vvck2js91.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197770>

Hi Junio,


On Fri, May 11, 2012 at 02:57:14PM -0700, Junio C Hamano wrote:
> * sg/bash-prompt (2012-05-09) 4 commits
>  - completion: respect $GIT_DIR
>  - completion: use __gitdir() in _git_log()
>  - tests: add tests for the bash prompt functions in the completion s=
cript
>  - tests: move code to run tests under bash into a helper library
>=20
> This is only the "correction" bits taken from the beginning of a larg=
er
> series that is to be rerolled.

The reroll will affect these patches, too, but it will only come in a
week or so later.  Please don't merge this topic into next yet.


G=E1bor
