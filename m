From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: how to reorder commits
Date: Mon, 20 Jul 2009 18:16:08 +0200
Message-ID: <adf1fd3d0907200916x752cba3cw901965788acae0c5@mail.gmail.com>
References: <f46c52560907200807heed4bbfkde15cccd2ae8151d@mail.gmail.com>
	 <adf1fd3d0907200837k63f21504v3d660f9503962fcf@mail.gmail.com>
	 <f46c52560907200901w67edbbdcpe405f28d98953354@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Rustom Mody <rustompmody@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 20 18:17:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSvYX-0006wm-Qs
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 18:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753024AbZGTQQN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Jul 2009 12:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbZGTQQM
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 12:16:12 -0400
Received: from an-out-0708.google.com ([209.85.132.250]:33755 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753017AbZGTQQJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jul 2009 12:16:09 -0400
Received: by an-out-0708.google.com with SMTP id d40so3741206and.1
        for <git@vger.kernel.org>; Mon, 20 Jul 2009 09:16:08 -0700 (PDT)
Received: by 10.100.144.14 with SMTP id r14mr6405407and.65.1248106568608; Mon, 
	20 Jul 2009 09:16:08 -0700 (PDT)
In-Reply-To: <f46c52560907200901w67edbbdcpe405f28d98953354@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123619>

2009/7/20 Rustom Mody <rustompmody@gmail.com>:
> On Mon, Jul 20, 2009 at 9:07 PM, Santi B=E9jar<santi@agolina.net> wro=
te:
>> But normally you reorder "changes", not trees.
>
> Which may not always be conflict-free?

No. But the fact that there is no porcelain way to do it may show that
reordering trees is not what you normally want, even if reordering
trees is conflict-free.

HTH,
Santi
