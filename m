From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: input director not compatible with git right-click
Date: Wed, 16 Nov 2011 10:22:19 +0530
Message-ID: <CAMK1S_hx3QkyBAq=7qhT17cqcfXWNNvnpphP5bu1cMV53TunmA@mail.gmail.com>
References: <loom.20111113T173332-656@post.gmane.org>
	<20111114144024.GD10025@beez.lab.cmartin.tk>
	<CAMK1S_jWcLQTqzqQcAMk8PjZ4ir7Y7a8QY=JvmX2qbQnzJO4ew@mail.gmail.com>
	<20111115173843.GB5453@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Eric <eric@mansionis.fr>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 05:52:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQXUB-0005t2-TD
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 05:52:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752544Ab1KPEwU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Nov 2011 23:52:20 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:33708 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752449Ab1KPEwU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2011 23:52:20 -0500
Received: by ggnb2 with SMTP id b2so8303387ggn.19
        for <git@vger.kernel.org>; Tue, 15 Nov 2011 20:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=xxH3vv2VdXQatcjml2ocRUgGd40qrT8kojgkVLg2AZ4=;
        b=L0TaR5PR94GC05eO54srz+CJwzBrMyEXIzHVqxRduI5PCjIi2dmzUF3Riw/C6FvGO5
         UAYixif0QGDReCJvdKzu5GFWCYTa9vOXR9Q+mABArIbOUh1kH8RnhYEBH5zEo+K5USva
         9lK4k7kv4hhOQC6qG8oNPbmlQTMOGH4+hZgUQ=
Received: by 10.182.111.8 with SMTP id ie8mr6698739obb.50.1321419139432; Tue,
 15 Nov 2011 20:52:19 -0800 (PST)
Received: by 10.182.165.9 with HTTP; Tue, 15 Nov 2011 20:52:19 -0800 (PST)
In-Reply-To: <20111115173843.GB5453@centaur.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185505>

On Tue, Nov 15, 2011 at 11:08 PM, Carlos Mart=C3=ADn Nieto <cmn@elego.d=
e> wrote:
> On Tue, Nov 15, 2011 at 09:39:25PM +0530, Sitaram Chamarty wrote:
>> On Mon, Nov 14, 2011 at 8:10 PM, Carlos Mart=C3=ADn Nieto <cmn@elego=
=2Ede> wrote:
>> > On Sun, Nov 13, 2011 at 04:34:26PM +0000, Eric wrote:
>> >> Hi,
>> >>
>> >> New in Git use, I use it do dev on window some administrative scr=
ipt. I use as
>> >> well Input director to share keyboard and mouse on multiple compu=
ter.
>> >
>> > Do you mean you're using it on the Windows OS?
>> >
>> >>
>> >> when I right-clicked on an item, it works when input director is =
disabled. If
>> >
>> > Right-click on what? git doesn't have a graphical interface. If yo=
u're
>> > using a graphical front-end to git, you should send them a bug rep=
ort.
>>
>> git comes with 3 perfectly cromulent graphical programs, and one of
>> them is indispensable.
>
> I guess we have diferent ideas of where "git" ends and other stuff
> starts. gitk, git-gui and what is the last one?

'git gui blame'
