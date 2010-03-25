From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: Pseudonymous commits
Date: Thu, 25 Mar 2010 12:05:20 +0100
Message-ID: <adf1fd3d1003250405i621fcb18uc918c67474c37115@mail.gmail.com>
References: <4BAADF34.3080806@gmail.com>
	 <4BA51E6B-7325-465A-B23E-7F3C5BF87700@mit.edu>
	 <4BAAE981.4040205@gmail.com>
	 <e51f4f551003242154p7fb20ffch790dd1ada15eca0@mail.gmail.com>
	 <4BAAEDF7.1080107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kris Shannon <kris@shannon.id.au>, git@vger.kernel.org
To: "Mike.lifeguard" <mike.lifeguard@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 25 12:06:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nukt6-0006gm-Fu
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 12:06:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752888Ab0CYLFX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Mar 2010 07:05:23 -0400
Received: from mail-fx0-f223.google.com ([209.85.220.223]:64223 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752746Ab0CYLFW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Mar 2010 07:05:22 -0400
Received: by fxm23 with SMTP id 23so940208fxm.21
        for <git@vger.kernel.org>; Thu, 25 Mar 2010 04:05:20 -0700 (PDT)
Received: by 10.103.163.20 with SMTP id q20mr3298646muo.131.1269515120391; 
	Thu, 25 Mar 2010 04:05:20 -0700 (PDT)
In-Reply-To: <4BAAEDF7.1080107@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143177>

On Thu, Mar 25, 2010 at 6:00 AM, Mike.lifeguard
<mike.lifeguard@gmail.com> wrote:
> In any case, is the answer "git can't do that" or not? Because that's
> actually the answer I'm interested in.

Git uses the author/committer info for diferent things. First, it is a
unique identifier (name+email); second it is used when dealing with
mails (in and out mails).

If you don=B4t use email (for review, or contributions) you can build
the identifier as you want without the need to be name and email, it
is up to the project. For my private projects I use name=3DSanti
email=3Dsanti, so the author/committer info is "Santi <santi>" and I
haven=B4t found problems. Note that I don=B4t send/reveive emails to
contribute, just fetch and push. Maybe it would be better to use a
user.email that resemble an email, with @ and such.

HTH,
Santi
