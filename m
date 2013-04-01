From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: Move hard-coded colors to .gitk
Date: Mon, 1 Apr 2013 18:10:59 +1100
Message-ID: <20130401071059.GA4427@iris.ozlabs.ibm.com>
References: <1364391651-5896-1-git-send-email-gauthier@ostervall.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, patthoyts@users.sourceforge.net
To: Gauthier =?iso-8859-1?Q?=D6stervall?= <gauthier@ostervall.se>
X-From: git-owner@vger.kernel.org Mon Apr 01 09:11:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMYu0-0002iW-RP
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 09:11:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757071Ab3DAHLI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Apr 2013 03:11:08 -0400
Received: from ozlabs.org ([203.10.76.45]:45526 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756898Ab3DAHLH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 03:11:07 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 594A92C010A; Mon,  1 Apr 2013 18:11:05 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <1364391651-5896-1-git-send-email-gauthier@ostervall.se>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219675>

On Wed, Mar 27, 2013 at 02:40:51PM +0100, Gauthier =D6stervall wrote:
> Colors that are changeable in Preferences gave no sufficient control,
> putting colors in the config file allows for easier configuration and
> sharing of color schemes.
>=20
> win32: Make the default foreground color that of window text rather
> than button text.
>=20
> Signed-off-by: Gauthier =D6stervall <gauthier@ostervall.se>

Thanks, applied.  I reworded the commit message to be clearer and
also changed the default filesepfgcolor to black, which is what
it was previously, for me at least.

Paul.
