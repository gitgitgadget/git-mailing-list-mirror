From: Adam Piatyszek <ediap@users.sourceforge.net>
Subject: Re: [galtgendo@o2.pl: Re: Git vs svn. Is ... possible ?]
Date: Fri, 28 Mar 2008 22:04:54 +0100
Message-ID: <47ED5D76.6070101@users.sourceforge.net>
References: <20080328143449.GD32646@blackspire> <864paq3nz7.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?UmFmYcWCIE11xbx5xYJv?= <galtgendo@o2.pl>,
	git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Mar 28 22:11:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfLqk-0008UX-94
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 22:10:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755194AbYC1VKP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Mar 2008 17:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755283AbYC1VKP
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 17:10:15 -0400
Received: from dorado.et.put.poznan.pl ([150.254.11.146]:64070 "EHLO
	dorado.et.put.poznan.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755040AbYC1VKO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2008 17:10:14 -0400
Received: from hydrus.et.put.poznan.pl (hydrus.et.put.poznan.pl [150.254.11.145])
	by dorado.et.put.poznan.pl (8.13.8/8.13.8) with ESMTP id m2SL6mZ5017563;
	Fri, 28 Mar 2008 22:06:49 +0100 (CET)
	(envelope-from ediap@users.sourceforge.net)
Received: from [192.168.1.4] (dbf151.neoplus.adsl.tpnet.pl [83.23.31.151])
	by hydrus.et.put.poznan.pl (8.11.7p1+Sun/8.11.6) with ESMTP id m2SL4w626538;
	Fri, 28 Mar 2008 22:04:59 +0100 (MET)
User-Agent: Thunderbird 2.0.0.12 (X11/20080229)
In-Reply-To: <864paq3nz7.fsf@lola.quinscape.zz>
X-Enigmail-Version: 0.95.6
OpenPGP: id=1F115CCB
X-PMX-Version: 5.4.1.325704, Antispam-Engine: 2.6.0.325393, Antispam-Data: 2008.3.28.134834
X-PMX-Spam: Gauge=IIIIIII, Probability=7%, Report='BODY_SIZE_1100_1199 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HIGHBITS 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78438>

* David Kastrup [28 III 2008 15:46]:
> Rafa=C5=82 Mu=C5=BCy=C5=82o <galtgendo@o2.pl> writes:
>> On Fri, Mar 28, 2008 at 02:36:25PM +0100, Adam Piatyszek wrote:
>>> PS. The encoding you used for your message is not playing well with=
 the=20
>>> Polish accented characters in your name ;)
>> I think it's your mail program, which is not plaing well with receiv=
ed
>> mail. My message was a standard, plain-text, UTF-8 encoded email sen=
t by
>> mutt.
>=20
> Actually, it wasn't.  The message body was only ASCII-encoded (which =
is
> perfectly fine as it did not contain any accented letter).  The From
> header with your name, however, was properly MIME-encoded as utf-8.
>=20
> So yes, it would seem like Adam's mail reader got into a tizzy when
> trying to create the attribution line from the From header.

Yes. You are right. It seems that Thunderbird is not rfc2047-compliant=20
in such a case. I guess I should submit a bug report ;)

Sorry for the noise!

/Adam


--=20
=2E:.  Adam Piatyszek (ediap)  .:.....................................:=
=2E
=2E:.  ediap@users.sourceforge.net  .:................................:=
=2E
