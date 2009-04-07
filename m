From: Paul Vincent Craven <paul@cravenfamily.com>
Subject: Re: git over http not re-authenticating after 301 redirect?
Date: Tue, 7 Apr 2009 14:25:53 -0500
Message-ID: <5591393c0904071225w7d5a426ap50cb5f973e34f802@mail.gmail.com>
References: <5591393c0904061914y5ea26812kcfc0d14b52ed4300@mail.gmail.com>
	 <Pine.LNX.4.64.0904071041200.5901@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Martin_Storsj=F6?= <martin@martin.st>
X-From: git-owner@vger.kernel.org Tue Apr 07 21:27:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrGxP-0004Nu-2L
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 21:27:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754218AbZDGTZ4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Apr 2009 15:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753271AbZDGTZ4
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 15:25:56 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:57891 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911AbZDGTZz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Apr 2009 15:25:55 -0400
Received: by yw-out-2324.google.com with SMTP id 5so2767140ywb.1
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 12:25:54 -0700 (PDT)
Received: by 10.231.20.3 with SMTP id d3mr171531ibb.18.1239132353257; Tue, 07 
	Apr 2009 12:25:53 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0904071041200.5901@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115979>

On Tue, Apr 7, 2009 at 2:42 AM, Martin Storsj=F6 <martin@martin.st> wro=
te:

> It's a long shot, but try see if you can upgrade to a newer version o=
f
> libcurl; I think I saw some issue like this when I was experimenting =
with
> different http auth setups last week, that was solved by using newer
> versions...

No luck, but thanks for the suggestion. Updating to the March 3 build
of curl 7.19.4 yielded the same results.

--=20
Paul Vincent Craven
http://www.cravenfamily.com
