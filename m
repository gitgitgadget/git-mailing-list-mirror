From: =?ISO-8859-1?Q?Gonzalo_Garramu=F1o?= <ggarra@advancedsl.com.ar>
Subject: git and unicode
Date: Tue, 08 Jan 2008 08:09:54 -0300
Message-ID: <47835A02.80404@advancedsl.com.ar>
References: <C3A86A49.10AEF%jefferis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 08 12:07:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCCIz-00057H-5A
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 12:07:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752991AbYAHLHJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jan 2008 06:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752985AbYAHLHJ
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 06:07:09 -0500
Received: from gorolba.terra.com ([66.119.66.228]:55986 "EHLO
	gorolba.terra.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752991AbYAHLHI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 06:07:08 -0500
Received: from elimba.terra.com (elimba.terra.com [66.119.66.67])
	by gorolba.terra.com (Postfix) with ESMTP id ACF83B1C0C0
	for <git@vger.kernel.org>; Tue,  8 Jan 2008 06:07:04 -0500 (EST)
X-Terra-Karma: 0%
X-Terra-Hash: b1ee8bfc3a6c2033d4759e2bafbceeed
Received-SPF: none (elimba.terra.com: 66.119.66.67 is neither permitted nor denied by domain of advancedsl.com.ar) client-ip=66.119.66.67; envelope-from=ggarra@advancedsl.com.ar; helo=[192.168.1.3];
Received: from [192.168.1.3] (unknown [201.255.32.186])
	(authenticated user ggarra@advancedsl.com.ar)
	by elimba.terra.com (Postfix) with ESMTP id 38D321BC056
	for <git@vger.kernel.org>; Tue,  8 Jan 2008 06:07:03 -0500 (EST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <C3A86A49.10AEF%jefferis@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69862>


=46orking a little from the recent CR/LF thread, I was wondering how do=
es=20
git deal with unicode files?

Most scripting languages (ruby, python, etc) are now allowing their=20
source code to be written in unicode (UTF-8, usually).  Will git=20
incorrectly categorize those source files as "binary"?


--=20
Gonzalo Garramu=F1o
ggarra@advancedsl.com.ar

AMD4400 - ASUS48N-E
GeForce7300GT
Xubuntu Gutsy
