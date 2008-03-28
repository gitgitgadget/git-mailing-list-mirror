From: David Kastrup <dak@gnu.org>
Subject: Re: [galtgendo@o2.pl: Re: Git vs svn. Is ... possible ?]
Date: Fri, 28 Mar 2008 15:46:52 +0100
Message-ID: <864paq3nz7.fsf@lola.quinscape.zz>
References: <20080328143449.GD32646@blackspire>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?UmFmYcWCIE11xbx5xYJv?= <galtgendo@o2.pl>
X-From: git-owner@vger.kernel.org Fri Mar 28 15:56:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfFzv-0008WM-04
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 15:56:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753776AbYC1Oxf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Mar 2008 10:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753887AbYC1Oxf
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 10:53:35 -0400
Received: from mail.quinscape.de ([212.29.44.217]:37974 "EHLO
	mail.quinscape.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753625AbYC1Oxe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Mar 2008 10:53:34 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Mar 2008 10:53:34 EDT
Received: (qmail-ldap/ctrl 13484 invoked from network); 28 Mar 2008 14:46:51 -0000
Received: from unknown (HELO lola.quinscape.zz) ([10.0.3.43])
          (envelope-sender <dak@gnu.org>)
          by ns.quinscape.de (qmail-ldap-1.03) with SMTP
          for <galtgendo@o2.pl>; 28 Mar 2008 14:46:51 -0000
Received: by lola.quinscape.zz (Postfix, from userid 1001)
	id 642F08FC5B; Fri, 28 Mar 2008 15:46:51 +0100 (CET)
In-Reply-To: <20080328143449.GD32646@blackspire> (=?utf-8?B?IlJhZmHFgiBN?=
 =?utf-8?B?dcW8ecWCbyIncw==?= message of
	"Fri, 28 Mar 2008 15:34:49 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
X-AntiVirus: checked by AntiVir MailGate (version: 2.1.3-2; AVE: 7.6.0.78; VDF: 7.0.3.91; host: quinx)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78416>

Rafa=C5=82 Mu=C5=BCy=C5=82o <galtgendo@o2.pl> writes:

> On Fri, Mar 28, 2008 at 02:36:25PM +0100, Adam Piatyszek wrote:
>>
>> PS. The encoding you used for your message is not playing well with =
the=20
>> Polish accented characters in your name ;)
> I think it's your mail program, which is not plaing well with receive=
d
> mail. My message was a standard, plain-text, UTF-8 encoded email sent=
 by
> mutt.

Actually, it wasn't.  The message body was only ASCII-encoded (which is
perfectly fine as it did not contain any accented letter).  The From
header with your name, however, was properly MIME-encoded as utf-8.

So yes, it would seem like Adam's mail reader got into a tizzy when
trying to create the attribution line from the From header.

--=20
David Kastrup
