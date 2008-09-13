From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANN] mtn2git v0.1
Date: Sat, 13 Sep 2008 02:45:04 -0700 (PDT)
Message-ID: <m3d4j8nzy9.fsf@localhost.localdomain>
References: <94a0d4530809121559w5f644174j461ec61cb2327fd8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: devel@pidgin.im, openembedded-devel@openembedded.org,
	monotone-devel@nongnu.org, git@vger.kernel.org
To: "Felipe Contreras" <felipe.contreras@gmail.com>
X-From: devel-bounces@pidgin.im Sat Sep 13 11:46:21 2008
Return-path: <devel-bounces@pidgin.im>
Envelope-to: gcgg-gaim-devel-259@gmane.org
Received: from homing.pidgin.im ([69.31.24.85])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeRho-0006hL-PY
	for gcgg-gaim-devel-259@gmane.org; Sat, 13 Sep 2008 11:46:17 +0200
Received: from localhost (localhost [127.0.0.1])
	by homing.pidgin.im (Postfix) with ESMTP id C3D2248FAE;
	Sat, 13 Sep 2008 05:45:11 -0400 (EDT)
Received: from homing.pidgin.im ([127.0.0.1])
	by localhost (homing.pidgin.im [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L6alDw5OyHci; Sat, 13 Sep 2008 05:45:10 -0400 (EDT)
Received: from homing.pidgin.im (localhost [127.0.0.1])
	by homing.pidgin.im (Postfix) with ESMTP id 87A1E48FB0;
	Sat, 13 Sep 2008 05:45:10 -0400 (EDT)
X-Original-To: devel@pidgin.im
Delivered-To: devel@pidgin.im
Received: from localhost (localhost [127.0.0.1])
	by homing.pidgin.im (Postfix) with ESMTP id 723FF48FB0
	for <devel@pidgin.im>; Sat, 13 Sep 2008 05:45:07 -0400 (EDT)
Received: from homing.pidgin.im ([127.0.0.1])
	by localhost (homing.pidgin.im [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WAPVsHV4EhpJ for <devel@pidgin.im>;
	Sat, 13 Sep 2008 05:45:07 -0400 (EDT)
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.150])
	by homing.pidgin.im (Postfix) with ESMTP id 09C0B48FAE
	for <devel@pidgin.im>; Sat, 13 Sep 2008 05:45:06 -0400 (EDT)
Received: by ey-out-1920.google.com with SMTP id 4so524066eyk.34
	for <devel@pidgin.im>; Sat, 13 Sep 2008 02:45:06 -0700 (PDT)
Received: by 10.103.11.5 with SMTP id o5mr3715603mui.85.1221299105884;
	Sat, 13 Sep 2008 02:45:05 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.227.225])
	by mx.google.com with ESMTPS id e10sm1497785muf.14.2008.09.13.02.45.02
	(version=TLSv1/SSLv3 cipher=RC4-MD5);
	Sat, 13 Sep 2008 02:45:04 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m8D9i2wb024935; 
	Sat, 13 Sep 2008 11:44:12 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m8D9hQCd024929;
	Sat, 13 Sep 2008 11:43:26 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to
	jnareb@gmail.com using -f
In-Reply-To: <94a0d4530809121559w5f644174j461ec61cb2327fd8@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
X-Pidgin-SpamProbe: GOOD 0.0000361 9726f859aff2da77220ee3dc90fc50a0
X-Pidgin-Spam-Flag: Clean
X-BeenThere: devel@pidgin.im
X-Mailman-Version: 2.1.9
Precedence: list
List-Id: "Discussion about the development of Pidgin,
	Finch and libpurple" <devel.pidgin.im>
List-Unsubscribe: <http://pidgin.im/cgi-bin/mailman/listinfo/devel>,
	<mailto:devel-request@pidgin.im?subject=unsubscribe>
List-Archive: <http://pidgin.im/pipermail/devel>
List-Post: <mailto:devel@pidgin.im>
List-Help: <mailto:devel-request@pidgin.im?subject=help>
List-Subscribe: <http://pidgin.im/cgi-bin/mailman/listinfo/devel>,
	<mailto:devel-request@pidgin.im?subject=subscribe>
Sender: devel-bounces@pidgin.im
Errors-To: devel-bounces@pidgin.im
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95796>

"Felipe Contreras" <felipe.contreras@gmail.com> writes:

> This is the result of various experiments I've been doing while trying
> to import mtn repositories into git. I've looked into other mtn2git
> scripts but none fitted my needs.

mtn or mnt?

> After some RFCs on git and monotone mailing lists it seems now that
> the script is going in the right direction.

When you feel this script to be ready, could you add it to the
"Interaction with other Revision Control Systems" section on
  http://git.or.cz/gitwiki/InterfacesFrontendsAndTools
As far as I can see there ain't any Monotone to Git converter on this
list.

TIA
-- 
Jakub Narebski
Poland
ShadeHawk on #git
