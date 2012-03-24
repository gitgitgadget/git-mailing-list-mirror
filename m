From: chaitanyaa nalla <nallachaitu@gmail.com>
Subject: gsoc idea adding javascript library / framework in gitweb
Date: Sat, 24 Mar 2012 12:02:31 +0530
Message-ID: <CACeyogcFJoUyAiTReDJK_nCMGBp+23OjcS407A1X=fqFR+aGag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 24 07:33:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBKXA-0005MD-8k
	for gcvg-git-2@plane.gmane.org; Sat, 24 Mar 2012 07:33:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752882Ab2CXGcc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Mar 2012 02:32:32 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:46503 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752407Ab2CXGcc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Mar 2012 02:32:32 -0400
Received: by obbeh20 with SMTP id eh20so3070528obb.19
        for <git@vger.kernel.org>; Fri, 23 Mar 2012 23:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=L4RS1ntYlmCViEdaIHsldnk13yHUARo9G0Cvsu640HI=;
        b=BQDad2Fajr1PfE3MbB0yo1mqTEKXmckBgmiJIYmKRAco5SVtE8QepEEJjnAwTWePW0
         RjtzYLtUsoXxvXArBFSb/2tCuFNilxk3KUKASMGgcQZ0mZLIO9A/lKN5SAbCKPTsZiMy
         u46bLLRzKx8ff7JOAnJuc8TnLgHE2r8m/H8uxrzpTYaPocEZHSDrQ4TB0ys/kb5kVS5A
         BZvJ4XcZpPaDAuoGmZxHhepuRuDrjxAwOq0Ygn3ywWUP1vTsGuK4Tl02iyHe9UPICpH+
         RtPmQbZq0GPe6F8+PCY2ucjASdvKK+dp+Z7Gtmq2ITKqL2P0noOkUkovPnqxBlwQ/C7Y
         KV7A==
Received: by 10.182.159.35 with SMTP id wz3mr13650201obb.47.1332570751680;
 Fri, 23 Mar 2012 23:32:31 -0700 (PDT)
Received: by 10.182.39.234 with HTTP; Fri, 23 Mar 2012 23:32:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193818>

Hello everyone ,


=A0I am chaitanya nalla, a final year undergraduate student from India =
and i
am pretty much interested in doing the project "Adding javascript libra=
ry /
framework in gitweb" suggested by respected Jakub, I have good experien=
ce
in javascript ,libraries like jquery,Dojo etc. As per the goals of the
project i will use the efficient ,concise ,cross browser compatible
frameworks where ever needed.Also i am planning to create a local libra=
ry
version with support for configuration and a good documentation.

Using the Dom features of javascript and traversing the whole document
object is quite cubersome and error prone .so i want to replace them us=
ing
well tested libraries that are cross browser compatible.

Emualiting onprogress in XMLHttpRequest :

Jquery and Yui provide only statuses success and error .Even Mootools
provide progress but are constrained to some browers only.It can be han=
dled
by using $.ajax Transport utility .

I will also take care progressive enhancement,by carefully implementing=
 the
basic functionality of the gitweb so that what ever may be the browser
version and type , internet connection the basic functionality will not
disrupted .

yours sincerely,
chaitanya nalla.
India.
