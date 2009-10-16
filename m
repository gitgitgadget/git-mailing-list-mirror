From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: Moving git
Date: Fri, 16 Oct 2009 17:41:40 +0200
Message-ID: <adf1fd3d0910160841h513dea5ag6f9ace400afd1c2e@mail.gmail.com>
References: <25926819.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Richard Lee <richard@webdezign.co.uk>
X-From: git-owner@vger.kernel.org Fri Oct 16 17:52:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Myp6Y-0006zS-9e
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 17:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761067AbZJPPmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 11:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761061AbZJPPmT
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 11:42:19 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:39807 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761053AbZJPPmS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 11:42:18 -0400
Received: by ewy4 with SMTP id 4so1712553ewy.37
        for <git@vger.kernel.org>; Fri, 16 Oct 2009 08:41:41 -0700 (PDT)
Received: by 10.216.88.79 with SMTP id z57mr617214wee.22.1255707700429; Fri, 
	16 Oct 2009 08:41:40 -0700 (PDT)
In-Reply-To: <25926819.post@talk.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130504>

On Fri, Oct 16, 2009 at 4:58 PM, Richard Lee <richard@webdezign.co.uk> wrote:
> I cloned a git directory/repository? and then moved it.

So you moved the original repository. Then you have to update the url
in the new/cloned repositories. I would edit .git/config and changed
the url entries with the new value.

HTH,
Santi
