From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Re* [PATCH] "not uptodate" changed to "has local changes"
Date: Mon, 19 May 2008 08:55:43 +0200
Message-ID: <D925ECD3-1EE2-48EB-B1E5-2604C10AD643@wincent.com>
References: <1209833972-12256-1-git-send-email-timcharper@gmail.com> <e2b179460805060631l506e2a6leaafc9c0acf3b05b@mail.gmail.com> <b8bf37780805151914j65ce5406xc5e6b3d29e3bfb9b@mail.gmail.com> <alpine.DEB.1.00.0805161125320.30431@racer> <1ED37CF1-EABD-4881-BA29-ED2CB1CE73FC@sb.org> <b8bf37780805162030m4c961505nabd72e8f5bd08404@mail.gmail.com> <alpine.DEB.1.00.0805171102480.30431@racer> <e06498070805170744l7ad213aeqb779b0c0381e1de4@mail.gmail.com> <bd6139dc0805170912w14b7894fxfebe15c14e4c44ef@mail.gmail.com> <7v63tcda7e.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: sverre@rabbelier.nl, "Steven Walter" <stevenrwalter@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	=?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?= <andre.goddard@gmail.com>,
	"Kevin Ballard" <kevin@sb.org>,
	"Mike Ralphson" <mike.ralphson@gmail.com>,
	"Tim Harper" <timcharper@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 19 08:57:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxzIn-00057H-8d
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 08:56:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753792AbYESG4G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 May 2008 02:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753872AbYESG4F
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 02:56:05 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:51524 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753646AbYESG4E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 May 2008 02:56:04 -0400
Received: from cuzco.lan (62.pool85-53-9.dynamic.orange.es [85.53.9.62])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id m4J6ti2n021893
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 19 May 2008 02:55:48 -0400
In-Reply-To: <7v63tcda7e.fsf_-_@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82416>

El 17/5/2008, a las 21:03, Junio C Hamano escribi=F3:
> +	/* not_uptodate_file */
> +	"Entry '%s' not uptodate. Cannot merge.",


Minor nit, "uptodate" is not a word. Should be either "up-to-date" or =20
"up to date"; most dictionaries list both.

Cheers,
Wincent
