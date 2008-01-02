From: =?ISO-8859-1?Q?Gonzalo_Garramu=F1o?= <ggarra@advancedsl.com.ar>
Subject: Re: Git and securing a repository
Date: Wed, 02 Jan 2008 07:39:41 -0300
Message-ID: <477B69ED.3090107@advancedsl.com.ar>
References: <477B39B5.5010107@advancedsl.com.ar>	 <31e679430801012234x20bbebe7vb496a338bf2699d5@mail.gmail.com>	 <477B6199.6070601@advancedsl.com.ar> <ee77f5c20801020126n1776d625ya6928c2e4bfdf497@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: David Symonds <dsymonds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 02 10:38:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JA03K-0001YB-Gr
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 10:38:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754895AbYABJhz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jan 2008 04:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754654AbYABJhy
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 04:37:54 -0500
Received: from echunga.terra.com ([66.119.66.230]:55523 "EHLO
	echunga.terra.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754459AbYABJhy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2008 04:37:54 -0500
Received: from elimba.terra.com (elimba.terra.com [66.119.66.67])
	by echunga.terra.com (Postfix) with ESMTP id 70C799540D5;
	Wed,  2 Jan 2008 04:37:53 -0500 (EST)
X-Terra-Karma: 0%
X-Terra-Hash: 300a6afa61de5ceba1d712527d062682
Received-SPF: none (elimba.terra.com: 66.119.66.67 is neither permitted nor denied by domain of advancedsl.com.ar) client-ip=66.119.66.67; envelope-from=ggarra@advancedsl.com.ar; helo=[192.168.1.3];
Received: from [192.168.1.3] (unknown [201.255.33.238])
	(authenticated user ggarra@advancedsl.com.ar)
	by elimba.terra.com (Postfix) with ESMTP id 87E4E1BC048;
	Wed,  2 Jan 2008 04:37:50 -0500 (EST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <ee77f5c20801020126n1776d625ya6928c2e4bfdf497@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69465>

David Symonds wrote:
>=20
> You can do arbitrarily-fine-grained authentication via the pre-receiv=
e hook.
>=20

Can you provide some more info?  Looking at the kernel.org git docs, th=
e=20
pre-receive hook seems very limited as no parameters are allowed.  So=20
I'm not sure how an authentication system could be created.

It also seems to be a push hook only (not invoked on pulls).



--=20
Gonzalo Garramu=F1o
ggarra@advancedsl.com.ar

AMD4400 - ASUS48N-E
GeForce7300GT
Xubuntu Gutsy
