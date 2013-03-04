From: "Gene Thomas [DATACOM]" <Gene.Thomas@datacom.co.nz>
Subject: rebase destroys branches
Date: Tue, 5 Mar 2013 12:06:10 +1300
Message-ID: <C057AC9B02D06A49810E9597C11F55BF14DFE51C9F@dnzwgex2.datacom.co.nz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_C057AC9B02D06A49810E9597C11F55BF14DFE51C9Fdnzwgex2datac_"
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 05 00:06:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCeSy-0006Ov-V8
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 00:06:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366Ab3CDXGP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Mar 2013 18:06:15 -0500
Received: from mx6.datacom.co.nz ([202.175.142.6]:1082 "EHLO mx6.datacom.co.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758586Ab3CDXGP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Mar 2013 18:06:15 -0500
Received: from dnzwgex2.datacom.co.nz (Not Verified[172.30.0.121]) by mx6.datacom.co.nz with MailMarshal (v6,4,1,5038) (using TLS: SSLv23)
	id <B513528e40000>; Tue, 05 Mar 2013 12:06:12 +1300
Received: from DNZWGEX2.datacom.co.nz ([172.30.0.121]) by
 dnzwgex2.datacom.co.nz ([172.30.0.121]) with mapi; Tue, 5 Mar 2013 12:06:11
 +1300
Thread-Topic: rebase destroys branches
Thread-Index: Ac4ZJ8zS72ai2u3hTRmQhbswhmfo7gABNc2w
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217418>

--_002_C057AC9B02D06A49810E9597C11F55BF14DFE51C9Fdnzwgex2datac_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0I am evaluating git for use in a company. Ple=
ase correct if I am wrong. I am concerned that an inexperienced developer c=
ould mistakenly rebase branches, destroying the original branch. Attached i=
s a script (Windoze) that shows the 'topic' branch being moved!, after the =
rebase we are unable to see the original branch, read it's history or find =
it's commit points.

Surely no operation should remove anything from the repository. Operations =
like this irreversibly break the repository . When rebasing the original br=
anch must be retained.

Yours faithfully,


Gene Thomas.


--_002_C057AC9B02D06A49810E9597C11F55BF14DFE51C9Fdnzwgex2datac_
Content-Type: application/octet-stream; name="git-test.bat"
Content-Description: git-test.bat
Content-Disposition: attachment; filename="git-test.bat"; size=1196;
	creation-date="Mon, 04 Mar 2013 23:05:57 GMT";
	modification-date="Mon, 04 Mar 2013 22:34:30 GMT"
Content-Transfer-Encoding: base64

DQpyZW0gaHR0cHM6Ly93d3cua2VybmVsLm9yZy9wdWIvc29mdHdhcmUvc2NtL2dpdC9kb2NzL2dp
dC1yZWJhc2UuaHRtbA0KDQpyZW0gKGMpIDIwMTMgR2VuZSBUaG9tYXMNCnJlbSBEYXRhY29tDQpy
ZW0gR2VuZS5UaG9tYXNAZGF0YWNvbS5jby5ueg0KDQppZiBleGlzdCAiZ2l0LXRlc3QiIHJtZGly
IC9xIC9zIGdpdC10ZXN0DQpta2RpciBnaXQtdGVzdA0KY2QgZ2l0LXRlc3QNCmdpdCBpbml0DQoN
CnJlbSA9PT09PT09PT09PT09PT09PT09PT09PT09PQ0KDQplY2hvIGQgPiBkLnR4dA0KZ2l0IGFk
ZCBkLnR4dA0KZ2l0IHRhZyBkDQpnaXQgY29tbWl0IC1hIC1tIGQNCg0KZWNobyBlID4gZS50eHQN
CmdpdCBhZGQgZS50eHQNCmdpdCB0YWcgZQ0KZ2l0IGNvbW1pdCAtYSAtbSBlDQoNCmdpdCBicmFu
Y2ggdG9waWMNCmdpdCBjaGVja291dCB0b3BpYw0KDQplY2hvIGEgPiBhLnR4dA0KZ2l0IGFkZCBh
LnR4dA0KZ2l0IHRhZyBhDQpnaXQgY29tbWl0IC1tIGENCg0KZWNobyBiID4gYi50eHQNCmdpdCBh
ZGQgYi50eHQNCmdpdCB0YWcgYg0KZ2l0IHRhZyB2Mi4wDQpnaXQgY29tbWl0IC1hIC1tIGINCg0K
ZWNobyBjID4gYy50eHQNCmdpdCBhZGQgYy50eHQNCmdpdCB0YWcgYw0KZ2l0IGNvbW1pdCAtYSAt
bSBjDQoNCmdpdCBsb2cNCg0KcmVtID09PT09PT09PT09PT09PT09PT09PT09PT09DQoNCmdpdCBj
aGVja291dCBtYXN0ZXINCg0KZWNobyBmID4gZi50eHQNCmdpdCBhZGQgZi50eHQNCmdpdCB0YWcg
Zg0KZ2l0IGNvbW1pdCAtYSAtbSBmDQoNCmVjaG8gZyA+IGcudHh0DQpnaXQgYWRkIGcudHh0DQpn
aXQgdGFnIGcNCmdpdCBjb21taXQgLWEgLW0gZw0KDQpyZW0gPT09PT09PT09PT09PT09PT09PT09
PT09PT0NCg0KZ2l0IGNoZWNrb3V0IHRvcGljDQpnaXQgcmViYXNlIG1hc3Rlcg0KDQpnaXQgbG9n
DQoNCnJlbSA9PT09PT09PT09PT09PT09PT09PT09PT09PQ0KDQpnaXQgY2hlY2tvdXQgdjIuMA0K
Z2l0IGJyYW5jaA0KcmVtIHdlIGFyZSBvbiB0aGUgIihubyBicmFuY2gpIiBwc3VlZG8gYnJhbmNo
DQoNCnJlbSBvcmlnaW9uYWwgJ3RvcGljJyBicmFuY2ggaXMgbG9zdA0KcmVtIGNvbW1pdHMgYXJl
IHN0aWxsIGluIHRoZSByZXBvc2l0cnkNCnJlbSBidXQgY2FuIG9ubHkgYmUgcmVmZXJlbmNlZCBi
eSBoYXNoIG9yIHRhZw0KcmVtIGEgbWlzdGFrZSB3b3VsZCBkZXN0cm95IHRoZSBoaXN0b3J5DQo=

--_002_C057AC9B02D06A49810E9597C11F55BF14DFE51C9Fdnzwgex2datac_--
