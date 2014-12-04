From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Subject: Antw: Re: Enhancement Request: "locale" git option
Date: Thu, 04 Dec 2014 16:51:10 +0100
Message-ID: <548090FE020000A100018323@gwsmtp1.uni-regensburg.de>
References: <54801C39020000A1000182FA@gwsmtp1.uni-regensburg.de>
 <54801B50.4080500@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>, <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Dec 04 16:51:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwYgX-00033T-FO
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 16:51:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753766AbaLDPvO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Dec 2014 10:51:14 -0500
Received: from rrzmta2.uni-regensburg.de ([194.94.155.52]:60769 "EHLO
	rrzmta2.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785AbaLDPvN (ORCPT
	<rfc822;groupwise-git@vger.kernel.org:1:1>);
	Thu, 4 Dec 2014 10:51:13 -0500
Received: from rrzmta2.uni-regensburg.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 74BEF5284F
	for <git@vger.kernel.org>; Thu,  4 Dec 2014 16:51:11 +0100 (CET)
Received: from gwsmtp1.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
	by rrzmta2.uni-regensburg.de (Postfix) with ESMTP id 577B3520B6
	for <git@vger.kernel.org>; Thu,  4 Dec 2014 16:51:11 +0100 (CET)
Received: from uni-regensburg-smtp1-MTA by gwsmtp1.uni-regensburg.de
	with Novell_GroupWise; Thu, 04 Dec 2014 16:51:11 +0100
X-Mailer: Novell GroupWise Internet Agent 14.0.1 
In-Reply-To: <54801B50.4080500@web.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260762>

>>> Torsten B=C3=B6gershausen <tboegi@web.de> schrieb am 04.12.2014 um =
09:29 in
Nachricht <54801B50.4080500@web.de>:
> On 12/04/2014 08:32 AM, Ulrich Windl wrote:
>> Hi!
>>
>> I'm native German, but German git messages confuse me (yopu'll have =
to=20
> correlate them with the man pages). At the moment git uses the locale=
=20
> settings from the environment, so you can only change git's locale se=
ttings

> by changing the environment (like "LANG=3D git ...").
>> OTOH Git has a flexible hierachical option setting mechanism. Why no=
t allow

> a Git language (locale) setting system-wde, user-wide, or
repository-specific.
>>
>> Regards,
>> Ulrich
> How about
> alias git=3D'LANGUAGE=3Dde_DE.UTF-8 git'
> in your ~/.profile ?
> (Of course you need to change de to the language you want )

That way no program ever needs configuration files ;-)
