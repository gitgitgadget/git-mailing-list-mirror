From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH v7 22/31] checkout: support checking out into a new
 working directory
Date: Thu, 17 Jul 2014 07:19:28 +0300
Message-ID: <20140717041928.GA10056@wheezy.local>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
 <1405227068-25506-1-git-send-email-pclouds@gmail.com>
 <1405227068-25506-23-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 06:20:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7dAs-0003CZ-Qk
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jul 2014 06:20:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753316AbaGQETw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jul 2014 00:19:52 -0400
Received: from p3plsmtpa07-08.prod.phx3.secureserver.net ([173.201.192.237]:50802
	"EHLO p3plsmtpa07-08.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751575AbaGQETs (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jul 2014 00:19:48 -0400
Received: from wheezy.local ([82.181.158.170])
	by p3plsmtpa07-08.prod.phx3.secureserver.net with 
	id TGKg1o0033gsSd601GKl4v; Wed, 16 Jul 2014 21:19:47 -0700
Content-Disposition: inline
In-Reply-To: <1405227068-25506-23-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253721>

Hi.

On Sun, Jul 13, 2014 at 11:50:59AM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
> +MULTIPLE CHECKOUT MODE
> +-------------------------------

This generates incorrect html for me, making all section
until next heading "EXAMPLES" into a preformatted text. If I
justify the line of dashes to be the exactly same width as
header it starts generating correctly looking html.

I'm not sure which software to refer to. I mostly use Debian
stable. The installed version of asciidocs is 8.6.7-1. I
suppose the line really should be justified because for all
other headings they are.

--=20
Max
