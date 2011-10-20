From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [msysGit] Re: Compiling on Windows
Date: Thu, 20 Oct 2011 08:06:16 +0100
Organization: OPDS
Message-ID: <A055FD803312493896025A226B6D6E29@PhilipOakley>
References: <CAH5451=7Em7sPzknVx8i2VBSAZxZwg1Awr8s3Nr2W=A6SDEZEw@mail.gmail.com> <4E9E811C.10205@lyx.org> <2015B7F2CEAE4B449EA4EF744F9B8FD9@PhilipOakley> <alpine.DEB.1.00.1110191816500.32316@s15462909.onlinehome-server.info>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Andrew Ardill" <andrew.ardill@gmail.com>,
	"Vincent van Ravesteijn" <vfr@lyx.org>,
	"Git MsysGit" <msysgit@googlegroups.com>, <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 20 09:06:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGmhk-000186-5b
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 09:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753991Ab1JTHGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Oct 2011 03:06:10 -0400
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:25393 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751681Ab1JTHGJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Oct 2011 03:06:09 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AhkJAPPHn05cHKAK/2dsb2JhbABEikKPE416LwGBDIEGBAMBAgGBXgEEAQEFCAEBLh4BASELAgMFAgEDFQECCSUUAQQaBgcJAQ0GEwgCAQIDAYU3B4IpCrU0h0ZhBIdTngQ
X-IronPort-AV: E=Sophos;i="4.69,377,1315177200"; 
   d="scan'208";a="12889436"
Received: from host-92-28-160-10.as13285.net (HELO PhilipOakley) ([92.28.160.10])
  by out1.ip07ir2.opaltelecom.net with SMTP; 20 Oct 2011 08:06:07 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6109
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184010>

From: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Sent: Thursday, October 20, 2011 12:17 AM
> On Wed, 19 Oct 2011, Philip Oakley wrote:
>
>> From: "Vincent van Ravesteijn" <vfr@lyx.org>
>> > Op 18-10-2011 6:08, Andrew Ardill schreef:
>> > > Hi list, I have been searching for details on what is required to
>> > > compile on Windows, but haven't found anything conclusive. Perhaps
>> > > there is something on the wiki, but unfortunately it is down at the
>> > > moment.
>
> The quickest way to get Git for Windows compiled is to download & run
> msysGit-netinstall from http://msysgit.googlecode.com/.
>
Johannes,
I've got the msysGit-netinstall, which is excellent, however it was the 
additional setting up of MSVC (Microsoft Visual Studio) that I was trying to 
get going as an IDE tool - Its a tool I have to use at work so I'm familiar 
with it. I know that an MSVC compilation is not perfect..., but it would 
allow me easier development before a proper gcc compilation.

The C:\msysgit\git\compat\vcbuild\README gave details of the extra parts to 
download but it wasn't clear to me where I should put them within the C:\ or 
C:\msysgit\ directory.

The msysGit-netinstall already includes git (C:\msysgit\git), so I wasn't 
sure if I should download it a second time as instructed in the README. With 
the improvements in msysGit-netinstall I expect that the README is slightly 
out of date for the case where the netinstall was used. The blog post gave 
an indication of _where_ the downloads were to be placed, but was otherwise 
very similar to the README instructions.

regards
Philip
