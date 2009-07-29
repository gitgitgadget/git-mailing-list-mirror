From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: git-reset any branch head
Date: Wed, 29 Jul 2009 13:16:54 +0200
Message-ID: <adf1fd3d0907290416q341ea6abi97828e75c50b7191@mail.gmail.com>
References: <loom.20090729T095925-556@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?B?Wm9sdOFuRvx6ZXNp?= <zfuzesi@eaglet.hu>
X-From: git-owner@vger.kernel.org Wed Jul 29 13:17:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MW79c-0005Vy-35
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 13:17:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754096AbZG2LQz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Jul 2009 07:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754089AbZG2LQz
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 07:16:55 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:64974 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754081AbZG2LQy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2009 07:16:54 -0400
Received: by mail-ew0-f226.google.com with SMTP id 26so732887ewy.37
        for <git@vger.kernel.org>; Wed, 29 Jul 2009 04:16:54 -0700 (PDT)
Received: by 10.216.21.194 with SMTP id r44mr2273056wer.80.1248866214830; Wed, 
	29 Jul 2009 04:16:54 -0700 (PDT)
In-Reply-To: <loom.20090729T095925-556@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124343>

2009/7/29 Zolt=E1nF=FCzesi <zfuzesi@eaglet.hu>:
> Hi, sometimes it would be nice to reset not only the current,
> but any given branch head. What do you think?

git update-ref

or do  you mean with porcelain commands?

HTH,
Santi
