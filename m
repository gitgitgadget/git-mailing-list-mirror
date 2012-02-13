From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: User authentication in GIT
Date: Mon, 13 Feb 2012 20:02:34 +0530
Message-ID: <CAMK1S_g5mk44vhTsFG4-kzMw7jMVvX0VK6pXAY=PFAgOEsccgw@mail.gmail.com>
References: <1328595129258-7261349.post@n2.nabble.com>
	<1328615262741-7262113.post@n2.nabble.com>
	<CALKQrgdvOhfhTPg+g+LqCb6XOQczcz-nYC61B9x4W5dB4Up5oA@mail.gmail.com>
	<1328632848471-7262934.post@n2.nabble.com>
	<CAMK1S_i=QUxf1CPDwdDn0+2-7fL5xxMZ67rHvR63a-vU1uq39Q@mail.gmail.com>
	<1328893056653-7273350.post@n2.nabble.com>
	<CAMK1S_gOhaX4SaUZk8RrByDa_HPuMLDs=T2M2djXDhvESJu1Vg@mail.gmail.com>
	<1329137674044-7280277.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: supadhyay <supadhyay@imany.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 15:32:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwwxN-0006uS-A2
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 15:32:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756687Ab2BMOcg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 09:32:36 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:61135 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751866Ab2BMOcf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Feb 2012 09:32:35 -0500
Received: by obcva7 with SMTP id va7so6677803obc.19
        for <git@vger.kernel.org>; Mon, 13 Feb 2012 06:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=KsFmjjX87T2rCeSSP5+1PO/d5KfI1/3xR1Uy4CSWHhA=;
        b=XgLVBHgDBubAHWrf36iFL5szgig8JPtK0DaKb8mxQfiMxcyF5Tmh0Ed6aP+a+5B3p8
         ZVdr2QmfL6bCUJeVoUerwtE9NG/Lwbg3n0jtNBP5HexDmKuJymcT2zeN6IYNMGucNlhb
         WQo8UZOMFjbzlIq7mBhJm6+mUi4l5Yk3vz6Fo=
Received: by 10.182.222.102 with SMTP id ql6mr11988226obc.2.1329143554787;
 Mon, 13 Feb 2012 06:32:34 -0800 (PST)
Received: by 10.182.175.106 with HTTP; Mon, 13 Feb 2012 06:32:34 -0800 (PST)
In-Reply-To: <1329137674044-7280277.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190628>

On Mon, Feb 13, 2012 at 6:24 PM, supadhyay <supadhyay@imany.com> wrote:
> Thanks Sitaram for your reply and guidance.
>
> From your document I can see there are three different method to install
> gitolite. May I know all methods advantage and disadvantage?

see first para after the 4 bullets in
http://sitaramc.github.com/gitolite/install.html#install_installing_and_upgrading_gitolite_
