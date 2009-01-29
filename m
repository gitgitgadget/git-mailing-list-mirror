From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH] contrib: add 'git bpush' to push to bundles
Date: Thu, 29 Jan 2009 17:05:53 +0100
Message-ID: <adf1fd3d0901290805s64161899u72905a31dfec2fc6@mail.gmail.com>
References: <1232408791-16834-1-git-send-email-santi@agolina.net>
	 <20090120064732.GA14580@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Jan 29 17:08:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSZQd-0000wH-R3
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 17:07:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756912AbZA2QF5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Jan 2009 11:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751875AbZA2QF5
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 11:05:57 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:50611 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756856AbZA2QF4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jan 2009 11:05:56 -0500
Received: by ewy14 with SMTP id 14so4283484ewy.13
        for <git@vger.kernel.org>; Thu, 29 Jan 2009 08:05:53 -0800 (PST)
Received: by 10.103.228.19 with SMTP id f19mr115769mur.18.1233245153045; Thu, 
	29 Jan 2009 08:05:53 -0800 (PST)
In-Reply-To: <20090120064732.GA14580@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107699>

2009/1/20 Mike Hommey <mh@glandium.org>:
> On Tue, Jan 20, 2009 at 12:46:31AM +0100, Santi B=E9jar wrote:
>> 'git bpush' updates the branches in a bundle, while adding the objec=
ts
>> necessary to complete the given branches. Basically, it is a 'git
>> push' for bundles.
>
> I think it'd be better to improve git-push to support that, instead o=
f
> adding yet another git command.

Yes, I also think it'd be better if git-push supports it, but this is
not a trivial task, and my script works now. So I think it makes sense
to add it to the *contrib* directory.

Santi
