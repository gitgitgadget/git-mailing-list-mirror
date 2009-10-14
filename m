From: =?UTF-8?B?SGVydsOpIENhdXdlbGllcg==?= <herve@itaapy.com>
Subject: Re: [PATCH 1/6] Open the pack file and keep a map on it.
Date: Wed, 14 Oct 2009 17:29:59 +0200
Message-ID: <4AD5EE77.3030802@itaapy.com>
References: <1255516669-26745-1-git-send-email-herve@itaapy.com> <fabb9a1e0910140548g2ad99ec4ia0f4cd4cb6fc409c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 17:44:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My611-0001Ku-NL
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 17:43:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934554AbZJNPfY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Oct 2009 11:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934552AbZJNPfX
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 11:35:23 -0400
Received: from evo.itaapy.com ([213.215.35.165]:39925 "EHLO evo.itaapy.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934520AbZJNPfW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 11:35:22 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Oct 2009 11:35:22 EDT
Received: (qmail 15851 invoked from network); 14 Oct 2009 15:27:48 -0000
Received: from itaapy-35-170.cnt.nerim.net (HELO ?10.0.0.55?) (herve@itaapy.com@213.215.35.170)
  by evo.itaapy.com with ESMTPA; 14 Oct 2009 15:27:48 -0000
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.4pre) Gecko/20091012 Lightning/1.0pre Thunderbird/3.0b4
In-Reply-To: <fabb9a1e0910140548g2ad99ec4ia0f4cd4cb6fc409c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130299>

On 14/10/2009 14:48, Sverre Rabbelier wrote:
> Heya,
>
> 2009/10/14 Herv=C3=A9 Cauwelier<herve@itaapy.com>:
>
> Please include a cover letter for series as long as these (anything
> larger than 4 should have a cover letter IMHO). Doing so makes it
> easier for those that follow the series to see what changed (assuming
> you write down what changed in the cover letter). Also, it makes it
> easier for those that were not following the series to drop in at the
> current version (assuming you provide a short summary of what the
> series is about in the cover letter).

Hi, indeed I forgot and send-email sent them without asking confirmatio=
n.

The only change is the comment by Shawn about keeping the PACK_TOC=20
constant as is and calling the other one PACK_HDR.

Regards

--=20
Herv=C3=A9 Cauwelier - ITAAPY - 9 rue Darwin 75018 Paris
T=C3=A9l. 01 42 23 67 45 - Fax 01 53 28 27 88
http://www.itaapy.com/ - http://www.cms-migration.com
