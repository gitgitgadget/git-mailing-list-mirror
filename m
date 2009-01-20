From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH] commit: more compact summary and without extra quotes
Date: Tue, 20 Jan 2009 01:00:30 +0100
Message-ID: <adf1fd3d0901191600k6fd7a364h3e55f9600960df03@mail.gmail.com>
References: <1232405116-2359-1-git-send-email-santi@agolina.net>
	 <alpine.DEB.1.00.0901200043400.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 20 01:02:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP44I-0001In-Re
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 01:02:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761475AbZATAAi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Jan 2009 19:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762554AbZATAAf
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 19:00:35 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:49686 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762544AbZATAAe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jan 2009 19:00:34 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1384368yxm.1
        for <git@vger.kernel.org>; Mon, 19 Jan 2009 16:00:31 -0800 (PST)
Received: by 10.100.142.15 with SMTP id p15mr572093and.33.1232409630919; Mon, 
	19 Jan 2009 16:00:30 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901200043400.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106413>

2009/1/20 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> On Mon, 19 Jan 2009, Santi B=E9jar wrote:
>
>> Original:
>> [master]: created d9a5491: "foo:bar"
>>
>> While with the patch it becomes:
>> [master d9a5491] foo:bar
>
> Maybe you want to mention that it saves screen estate.  After all, th=
e
> commit message is _the_ place to relate your motivation to the gentle
> reader.

I thought it was enough with the "more compact" in the title line.

>
>> As discussed in the git mailing list:
>>
>> http://marc.info/?l=3Dgit&m=3D122765031208922&w=3D2
>>
>> Signed-off-by: Santi B=E9jar <santi@agolina.net>
>> ---
>
> You really want to move the link after the ---.  I often read commit
> messages off-line, and let me tell you: I am not really happy reading
> links then.  Not at all.

OK, less work for me :-)

Santi
