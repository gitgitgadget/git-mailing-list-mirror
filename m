From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH 4/4] Rename push.default to push.style
Date: Mon, 30 Mar 2009 11:07:10 +0200
Message-ID: <adf1fd3d0903300207j479b6e91gc6ed00695a00e157@mail.gmail.com>
References: <1238281804-30290-1-git-send-email-santi@agolina.net>
	 <1238281804-30290-5-git-send-email-santi@agolina.net>
	 <20090330080115.GA19142@pvv.org>
	 <alpine.DEB.1.00.0903301021540.7534@intel-tinevez-2-302>
	 <adf1fd3d0903300200v65393b1bif0050392aa44652e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Finn Arne Gangstad <finnag@pvv.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 30 11:09:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoDUp-0001SX-UD
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 11:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755962AbZC3JHO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Mar 2009 05:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755609AbZC3JHN
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 05:07:13 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:35097 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754550AbZC3JHN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Mar 2009 05:07:13 -0400
Received: by fxm2 with SMTP id 2so1855075fxm.37
        for <git@vger.kernel.org>; Mon, 30 Mar 2009 02:07:10 -0700 (PDT)
Received: by 10.103.2.14 with SMTP id e14mr1591815mui.41.1238404030443; Mon, 
	30 Mar 2009 02:07:10 -0700 (PDT)
In-Reply-To: <adf1fd3d0903300200v65393b1bif0050392aa44652e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115112>

2009/3/30 Santi B=E9jar <santi@agolina.net>:
> 2009/3/30 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>> On Mon, 30 Mar 2009, Finn Arne Gangstad wrote:
>>> Some people may have started setting push.default already, so chang=
ing
>>> the name may cause additional grief.
>>
>> ... indeed, it is too late now. =A0The milk has boiled already.
>
> I have it configured, but I think we can fix these type of things
> while they are in 'next'.
>

Now that I've recheck it, it seems to be in 'master', it's less clear,
but I still think we can fix these type of things while they are not
in a relased version.

The people with that setting is following the development version, and
can easily notice/change it.

Santi
