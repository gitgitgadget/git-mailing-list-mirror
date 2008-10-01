From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <santi@agolina.net>
Subject: Re: [PATCH/resent 0/9] Sparse checkout (first half)
Date: Wed, 1 Oct 2008 13:25:23 +0200
Message-ID: <adf1fd3d0810010425r145396b0t52cf883576da8bbd@mail.gmail.com>
References: <1222833849-22129-1-git-send-email-pclouds@gmail.com>
	 <adf1fd3d0810010320v340230f0jb443bafc1ef05d6f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: "=?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?=" 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 13:26:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkzqm-0000x6-U4
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 13:26:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752561AbYJALZ0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Oct 2008 07:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752003AbYJALZZ
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 07:25:25 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:25028 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752559AbYJALZZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2008 07:25:25 -0400
Received: by nf-out-0910.google.com with SMTP id d3so193214nfc.21
        for <git@vger.kernel.org>; Wed, 01 Oct 2008 04:25:23 -0700 (PDT)
Received: by 10.103.170.13 with SMTP id x13mr5724118muo.27.1222860323373;
        Wed, 01 Oct 2008 04:25:23 -0700 (PDT)
Received: by 10.102.247.10 with HTTP; Wed, 1 Oct 2008 04:25:23 -0700 (PDT)
In-Reply-To: <adf1fd3d0810010320v340230f0jb443bafc1ef05d6f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97217>

On Wed, Oct 1, 2008 at 12:20 PM, Santi B=E9jar <santi@agolina.net> wrot=
e:
> Not in this half but I've seen that you added a --default-sparse flag
> to "git clone". I think it is useless as mostly always the one given
> in -sparse-checkout should be used.

To be more precise, whenever you do "git clone --sparse-checkout" you
will want it to be the default sparse pattern.

Best regards,

Santi
