From: <dag@cray.com>
Subject: Re: organizing multiple repositories with dependencies
Date: Tue, 24 Apr 2012 18:36:48 -0500
Message-ID: <nng7gx41z3j.fsf@transit.us.cray.com>
References: <1334568432.53977.YahooMailNeo@web65906.mail.ac4.yahoo.com>
	<CAPZPVFbHseYHdPOXmbyGxncZmmzSHwY_fJkNRRQAMVtGZBA0CQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Namit Bhalla <namitbhalla@yahoo.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 01:37:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMpI9-0001A4-9N
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 01:37:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255Ab2DXXg4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 19:36:56 -0400
Received: from exprod6og105.obsmtp.com ([64.18.1.189]:34819 "EHLO
	exprod6og105.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932241Ab2DXXgy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 19:36:54 -0400
Received: from CFWEX01.americas.cray.com ([136.162.34.11]) (using TLSv1) by exprod6ob105.postini.com ([64.18.5.12]) with SMTP
	ID DSNKT5c5FDhxBtMSf1MJCxmIVGljf3+pYESv@postini.com; Tue, 24 Apr 2012 16:36:54 PDT
Received: from transit.us.cray.com (172.31.17.53) by CFWEX01.americas.cray.com
 (172.30.88.25) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 24 Apr
 2012 18:36:52 -0500
In-Reply-To: <CAPZPVFbHseYHdPOXmbyGxncZmmzSHwY_fJkNRRQAMVtGZBA0CQ@mail.gmail.com>
	(Eugene Sajine's message of "Tue, 24 Apr 2012 15:48:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196291>

Eugene Sajine <euguess@gmail.com> writes:

> What you are asking about is "integration" and IMHO has nothing to do
> with git - i.e. should be VCS independent.

Indeed, integration is another good strategy.  I mainly use submodules
as a convenience because it is a frequent (though not regular)
occurrence that we want to change multiple libraries at the same time.
Plus it provides a convenient way for developers to check out "the
project."

Again, it depends on the development practice and individual situations.
:)

                                   -Dave
