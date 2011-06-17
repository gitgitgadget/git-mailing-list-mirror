From: Massimo Manca <massimo.manca@micronengineering.it>
Subject: Re: git bash
Date: Fri, 17 Jun 2011 17:07:44 +0200
Organization: Micron Engineering
Message-ID: <4DFB6DC0.7070101@micronengineering.it>
References: <4DFB5C37.1090606@micronengineering.it> <20110617141822.GD7751@centaur.lab.cmartin.tk> <4DFB6710.8090105@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010003030905010506050007"
Cc: =?ISO-8859-15?Q?Carlos_Mart=EDn_Nieto?= <carlos@cmartin.tk>,
	git@vger.kernel.org
To: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Fri Jun 17 17:09:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXafr-0005aI-E3
	for gcvg-git-2@lo.gmane.org; Fri, 17 Jun 2011 17:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759208Ab1FQPJ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jun 2011 11:09:26 -0400
Received: from mp1-smtp-5.eutelia.it ([62.94.10.165]:33681 "EHLO
	smtp.eutelia.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751254Ab1FQPJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2011 11:09:26 -0400
Received: from [127.0.0.1] (ip-227-68.sn1.eutelia.it [62.94.227.68])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.eutelia.it (Eutelia) with ESMTP id 1408E1441D8;
	Fri, 17 Jun 2011 17:09:24 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; it; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <4DFB6710.8090105@dirk.my1.cc>
X-Antivirus: avast! (VPS 110617-0, 17/06/2011), Outbound message
X-Antivirus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175953>

This is a multi-part message in MIME format.
--------------010003030905010506050007
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit

Il 17/06/2011 16.39, Dirk Süsserott ha scritto:
> Am 17.06.2011 16:18 schrieb Carlos Martín Nieto:
>> On Fri, Jun 17, 2011 at 03:52:55PM +0200, Massimo Manca wrote:
>>> Hi all,
>>> I am using git on Linux Ubuntu, Windows Vista, , Windows 7 and Windows
>>> XP (several o.s. to develop sw).
>>> In my notebook under Vista if I use bash on mi physical HD (it is
>>> divided in C:, F:, H:) it works, if I try to open a bash console on an
>> Assuming you mean that git doesn't work (rather than bash), could you
>> provide a transcript of what you think went wrong?
>>
>>> external HD (or USB or SD memories) and also on network shared drives it
>>> doesn't work.
>> Are these filsystems FAT32 by any chance. You may need to turn on a
>> couple of compatibility options like case-insensitivity and filemode.
> But when using msysGit, these options are already set appropriate,
> aren't they?
Yes they are.
> Sometimes I have a similar problem. What do you mean by "opening a bash
> console on an external HD"?
Yes, it is more user friendly.
>  Do you right-click a folder and then "Git
> bash (here)"? I don't use that feature but I always start the bash with
> its regular icon (so my answer may probably not help you).  It then
> starts in my $HOME and I change to the external HD (say X:) like so:
>
> $ cd /x/foo
Opening a bash shell from the icon and then changing the working
folder.... it works :)
Very strange bug.
> I noticed the following: When the ext. HD is attached/mounted *before* I
> start the bash, then it works. But if I have a running bash and then
> mount the drive, I cannot cd to it. "No such path" or sth. It seems,
> that bash builds a list of available drives only at startup. Might that
> be your problem? If so, then close all bashs and re-open them after
> mounting the devices.
>
In my situation the external HD (an SD card) it is always on.
> HTH,
> Dirk
>
>


--------------010003030905010506050007
Content-Type: text/x-vcard; charset=utf-8;
 name="massimo_manca.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="massimo_manca.vcf"

begin:vcard
fn:Massimo Manca
n:Manca;Massimo
org:Micron Engineering di Massimo Manca
adr:;;via della Ferriera, 48;Pordenone;PN;33170;ITALIA
email;internet:massimo.manca@micronengineering.it
tel;work:+39 0434 1856131
tel;fax:+39 0434 1851032 / 178 273 3543
tel;cell:+39 349 4504979
url:http://www.micronengineering.it
version:2.1
end:vcard


--------------010003030905010506050007--
