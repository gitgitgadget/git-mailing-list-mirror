From: <dag@cray.com>
Subject: Re: Subtree in Git
Date: Mon, 7 May 2012 16:57:16 -0500
Message-ID: <nngzk9jvemb.fsf@transit.us.cray.com>
References: <CAE1pOi2uT=wipyrOYCwy9QuXnXFV27F1gN3Ej-RaSr-fegQCfA@mail.gmail.com>
	<nngk410vrja.fsf@transit.us.cray.com> <4F9FA029.7040201@initfour.nl>
	<87fwbgbs0h.fsf@smith.obbligato.org>
	<7v8vh78dag.fsf@alter.siamese.dyndns.org>
	<4FA82799.1020400@initfour.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Junio C Hamano <gitster@pobox.com>, <greened@obbligato.org>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Herman van Rink <rink@initfour.nl>
X-From: git-owner@vger.kernel.org Tue May 08 00:01:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRVzg-0000OA-Bo
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 00:01:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754906Ab2EGWBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 18:01:19 -0400
Received: from exprod6og105.obsmtp.com ([64.18.1.189]:50068 "EHLO
	exprod6og105.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998Ab2EGWBT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 18:01:19 -0400
Received: from CFWEX01.americas.cray.com ([136.162.34.11]) (using TLSv1) by exprod6ob105.postini.com ([64.18.5.12]) with SMTP
	ID DSNKT6hGJ4nJjVbUA8ko+ipPi9zPxqq8nHmO@postini.com; Mon, 07 May 2012 15:01:19 PDT
Received: from transit.us.cray.com (172.31.17.53) by CFWEX01.americas.cray.com
 (172.30.88.25) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 7 May
 2012 16:57:19 -0500
In-Reply-To: <4FA82799.1020400@initfour.nl> (Herman van Rink's message of
	"Mon, 7 May 2012 21:50:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197319>

Herman van Rink <rink@initfour.nl> writes:

> As an alternative I've now applied a patch with all changes on a clean
> master branch.
> In the commit message I've named all committers from the original history.
> Would that be acceptable?

Seems ok to me but Junio has the final say.

> Its now available as https://github.com/helmo/git/tree/subtree-updates
> The subtree merge version is still available as
> https://github.com/helmo/git/tree/subtree-updates-merged

Cool.  I'll take a look, probably Wednesday at the earliest.

                            -Dave
