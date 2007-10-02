From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: Re: metastore (was: Track /etc directory using Git)
Date: Tue, 2 Oct 2007 21:58:16 +0200
Message-ID: <20071002195816.GA6759@hardeman.nu>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net> <Pine.LNX.4.64.0709151507310.28586@racer.site> <20070915145437.GA12875@piper.oerlikon.madduck.net> <Pine.LNX.4.64.0709151430040.5298@iabervon.org> <20070916060859.GB24124@piper.oerlikon.madduck.net> <20070919191607.GE13683@hardeman.nu> <20071002195301.GB14171@lapse.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Tue Oct 02 21:57:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcnrY-0004BZ-Lh
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 21:57:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756358AbXJBT4k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Oct 2007 15:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756327AbXJBT4j
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 15:56:39 -0400
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:57097 "EHLO
	palpatine.hardeman.nu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756164AbXJBT4h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Oct 2007 15:56:37 -0400
Received: from ip54532fb6.speed.planet.nl ([84.83.47.182] helo=austin)
	by palpatine.hardeman.nu with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <david@hardeman.nu>)
	id 1Icnr2-0005s4-Od; Tue, 02 Oct 2007 21:56:28 +0200
Received: by austin (Postfix, from userid 1000)
	id 33FA429000A; Tue,  2 Oct 2007 21:58:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20071002195301.GB14171@lapse.madduck.net>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59720>

On Tue, Oct 02, 2007 at 08:53:01PM +0100, martin f krafft wrote:
>also sprach David H=E4rdeman <david@hardeman.nu> [2007.09.19.2016 +010=
0]:
>> But I agree, if any changes were made to git, I'd advocate adding
>> arbitrary attributes to files (much like xattrs) in name=3Dvalue
>> pairs, then any extended metadata could be stored in those
>> attributes and external scripts/tools could use them in some way
>> that makes sense...and also make sure to only update them when it
>> makes sense.
>
>So where would those metdata be stored in your opinion?

I'm not sufficiently versed in the internals of git to have an informed=
=20
opinion :)

--=20
David H=E4rdeman
